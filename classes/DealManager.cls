public inherited sharing class DealManager {
    
    //Deal Record Type Lease = 00h5i0000066HM6 AAM
    //Deal Record Type Sale = 00h5i0000066HLI AA2
   
     public static List<Deal__c> getDealsByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Id IN :ids');
   }


    public static Deal__c createContact(Id propertyId, Id sellerId, Id brokerId, String status, Id type, Boolean serialize){
       	
        Deal__c dl = new Deal__c();
        dl.Property__c = propertyId;
        dl.Seller_Contact__c = sellerId;
        dl.Broker__c = brokerId;
        dl.Status__c = status;
        dl.RecordTypeId = type;
        
        if (serialize) insert dl;

       	return dl;
    }
    
   public static Deal__c updateConByName(String searchName, Id propertyId, Id sellerId, Id brokerId, String status, Id type, Boolean serialize){
    Deal__c queriedDl = [SELECT Property__c, Seller_Contact__c, Broker__c, Status__c FROM Deal__c WHERE Name=:searchName];
        queriedDl.Property__c = propertyId;
        queriedDl.Broker__c = brokerId;
        queriedDl.Seller_Contact__c = sellerId;
        queriedDl.Status__c = status;
        queriedDl.RecordTypeId = type;
        
        if (serialize) update queriedDl;
        
    	return queriedDl;
    }
    
    public static void deleteDealByTypes(List<String> typesId) {
    	delete [SELECT Id FROM Deal__c WHERE RecordTypeId IN :typesId];
    }

    public static List<Deal__c> getNotClosedSaleDealsByProperties(List<Id> propertyIds) {
        return [
        SELECT Id
        FROM Deal__c
        WHERE Property__c IN :propertyIds
        AND Status__c NOT IN ('Closed Won', 'Closed', 'Closed Lost')
        AND RecordTypeId = :SALE_RECORD_TYPE_ID
        ];
    }
}
