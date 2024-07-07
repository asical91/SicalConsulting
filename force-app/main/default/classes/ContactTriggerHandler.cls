public class ContactTriggerHandler {
    public static void createUsers(List<Contact> newContacts) {
        List<User> usersToCreate = new List<User>();

        //Fetch the Profile ID for the 'Customer Community User' profile
        //Replace with the actual profile name or ID you need
        Profile communityProfile = [SELECT Id from Profile Where Name = 'Customer Community User' LIMIT 1];

        for (Contact con: newContacts) {
            if(con.email != null && con.FirstName != null && con.LastName != null){
                User newUser = New User();
                newUser.UserName = con.Email;
                newUser.Email = con.Email;
                newUser.FirstName = con.FirstName;
                newUser.LastName = con.LastName;
                newUser.Alias = (con.FirstName.length() > 1 ? con.FirstName.substring(0,1) : con.FirstName) + (con.LastName.length() > 4 ? con.LastName.substring(0, 4) : con.LastName);
                newUser.ProfileId = communityProfile.Id;
                newUser.TimeZoneSidKey = 'America/Los_Angeles'; // Adjust as needed
                newUser.LocaleSidKey = 'en_US'; // Adjust as needed
                newUser.EmailEncodingKey = 'UTF-8'; // Adjust as needed
                newUser.LanguageLocaleKey = 'en_US'; // Adjust as needed
                newUser.ContactId = con.Id;

                usersToCreate.add(newUser);
            }
        }

        if(!usersToCreate.isEmpty()) {
            try {
                insert usersToCreate;
            } catch (DmlException e) {
                //handle exceptions
                System.debug('Error creating users: " + e.getMessage()):
            }
        }
    }
}