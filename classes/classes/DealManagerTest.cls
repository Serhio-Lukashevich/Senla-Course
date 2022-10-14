@IsTest
public class DealManagerTest {
    
    public static final Id PropertyTestId = 'a015i00000UzgW7AAJ';
    public static final Id SellerTestId = '0035i00000BVdMbAAL';
    public static final Id BrokerTestId = '0035i00000BVdNFAA1';

	    
    @IsTest static void getDealsbyIdsTest(){      
        Deal__c dl = new Deal__c();       
        
        list<Id> ids = new list<Id>();
        
        //TestDeal Id
        ids.add('a025i0000072cS3AAI');
        
        list<Deal__c> dlTest = DealManager.getDealsByIds(ids, 'Name');
        
   
    }
    
    @IsTest static void createDealTest(){
        Deal__c dl = new Deal__c();
        dl = DealManager.createDeal('propertyId', 'sellerId', 'brokerId', 'status', 'type', true);
       
    }
    
  
   
	@IsTest static void updateDealByNameTest(){
       Deal__c dl = new Deal__c();
       dl = DealManager.updateDealByName('D-0009', PropertyTestId, SellerTestId, BrokerTestId, 'Open', 'Sale', true);

    }
    
   
    @IsTest static void deleteDealsByNameTest() {
		list<String> typesId = new list<String>();
        typesId.add('Sale');
        DealManager.deleteDealByTypes(typesId);
        list<Deal__c> dl = [SELECT Id FROM Deal__c WHERE RecordTypeId IN :typesId];
        System.assertEquals(dl, null);
    }
    
    
}