@isTest
public class BatchEndRentalTest {
    public static final Id DEAL_RECORD_TYPE_LEASE = '00h5i0000066HM6AAM';
    public static final Id SPACE_RECORD_TYPE_ID = '0125i000000pb7vAAA';
    public static final Double PROPERTY_PRICE = 2400120;
    public static final Double PROPERTY_RENT_PRICE = 6500;
                                            
    @testSetup
    static void setup() {
        String nextDay = String.valueOf(Datetime.now().addHours(3).addDays(1).date());
        Contact owner1 = TestDataFactory.createContact('Test Contact', '321312313');


        Property__c prop1 = TestDataFactory.createProperty('test', propPrice, propRentPrice, spaceRecordTypeId);

        Deal__c lease1 = TestDataFactory.createDeal('Open', DEAL_RECORD_TYPE_LEASE);
        Deal__c lease2 = TestDataFactory.createDeal('Closed Won', DEAL_RECORD_TYPE_LEASE);

    }
    @isTest static void BatchEndRentalTest() {
        Test.startTest();
        BatchEndRental btch = new BatchEndRental();
        Id batchId = Database.executeBatch(btch);
        Test.stopTest();

        Log__c log = [SELECT Type__c, Message__c FROM Log__c WHERE Type__c = 'Batch Errors' LIMIT 1];
        System.assertEquals('0', log.Message__c);
    }
}