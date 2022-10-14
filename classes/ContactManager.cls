public inherited sharing class ContactManager {
    
    //Contact Record Type Broker = 0125i000000pa23
    //Contact Record Type Seller = 0125i000000pbkg
    //
     public static List<Contact> getContactsByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Contact WHERE Id IN :ids');
   }


    public static Contact createContact(String firstName, String lastName, String phone, Id type, Boolean serialize){
        //RecordType brokerRecordType = [select Id from RecordType where Name = 'Mrs. Arnold Hoffington' and SobjectType = 'Contact' limit 1];
        Contact con = new Contact();
        con.FirstName = firstName;
        con.LastName = lastName;
        con.Phone = phone;
        con.RecordTypeId = type;
        
        if (serialize) insert con;

       	return con;
    }
    
   public static Contact updateConByName(String searchName, String firstName, String lastName, String phone, Boolean serialize){
    Contact queriedCon = [SELECT Name, FirstName, LastName, Phone FROM Contact WHERE Name=:searchName];
        queriedCon.FirstName = firstName;
        queriedCon.LastName = lastName;
        queriedCon.Phone = phone;
        
        if (serialize) update queriedCon;
        
    	return queriedCon;
    }
    
    public static void deleteContactsByTypes(List<String> typesId) {
    	delete [SELECT Id FROM Contact WHERE RecordTypeId IN :typesId];
    }
    
    
        
}
