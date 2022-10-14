@IsTest
public class PropertyManagerTest {
    
    public static final Id PropRecordTypeId = '0125i000000pb7qAAA';
	    
    @IsTest static void getPropertyByIdTest(){      
        Property__c prop = new Property__c();       
        
        list<Id> ids = new list<Id>();
        //TestProperty Id
        ids.add('a015i00000UzgW7AAJ');
        list<Property__c> propTest = PropertyManager.getPropertyByIds(ids, 'Name');
        
   
    }
    
    @IsTest static void createPropertyTest(){
        Property__c prop = new Property__c();
        prop = PropertyManager.createProperty('nameTest', 270000, 13000, 
                                            'adressTest', 'a035i000004opTOAAY', PropRecordTypeId, true);
       
    }
    
  
   
	@IsTest static void updatePropertyByNameTest(){
       Property__c dl = new Property__c();
       dl = PropertyManager.updatePropertyByName('Burlington evaluation', 'nameTest', 270000, 13000, 
                                                 'adressTest', PropRecordTypeId, true);

    }
    
   
    @IsTest static void deletePropertyByNameTest() {
		list<String> typesId = new list<String>();
        typesId.add('0125i000000pb80AAA');
        PropertyManager.deletePropertyByTypes(typesId);
        list<Property__c> prop = [SELECT Id FROM Property__c WHERE RecordTypeId IN :typesId];
        System.assertEquals(prop, null);
    }
    
    
}