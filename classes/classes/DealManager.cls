public inherited sharing class DealManager {
    
    //Deal Record Type Lease = 00h5i0000066HM6 AAM
    //Deal Record Type Sale = 00h5i0000066HLI AA2
   
     public static List<Deal__c> getDealsByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Id IN :ids');
   }


   public class DealWrapper{
        public Id property {get; set;}
        public Id broker {get; set;}
        public Id seller {get; set;}
        public String status {get; set;}
        public String recordTypeName {get; set;}
        public Id recordTypeId {get; set;}
        public Date leaseStartDate {get; set;}
        public Date leaseEndDate {get; set;}
        public Decimal revenue {get; set;}

        public DealWrapper(Deal__c deal) {
            this.sellingProperty = deal.Property__c;
            this.broker = deal.Broker__c;
            this.seller = deal.Seller_Contact__c;
            this.recordTypeDeveloperName = deal.recordType.DeveloperName;
            this.leaseStartDate = deal.Start_Of_The_Lease_c;
            this.leaseEndDate = deal.End_Of_The_Lease__c;
            this.revenue = deal.Final_Amount__c;
        }
        public DealWrapper() {

        }
    }

    public static Deal__c createDeal(DealWrapper wrapper, Boolean serialize) {
        Deal__c deal = new Deal__c();
        deal.Broker__c = wrapper.realtor;
        deal.Seller_Contact__c = wrapper.seller;
        deal.Selling_Property__c = wrapper.sellingProperty;
        deal.RecordTypeId = wrapper.recordTypeId;
        if (deal.RecordTypeId == RECORD_TYPE_LEASE_ID) {
            deal.Lease_End_Date__c = wrapper.leaseEndDate;
            deal.Lease_Start_Date__c = wrapper.leaseStartDate;
        }
        deal.Status__c = String.isBlank(wrapper.status) ? DEFAULT_STATUS : wrapper.status;

        if (serialize) insert deal;

        return deal;
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

    public static List<Deal__c> getDealsByPeriodAndProperty(Id property, Date startDate, Date endDate, String recordType, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Property__c = :property AND Start_Of_The_lease__c = :startDate' +
                                                                        ' AND End_Of_The_Lease__c = :endDate AND RecordType.DeveloperName = :recordType');
    }
}
