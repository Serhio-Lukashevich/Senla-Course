public inherited sharing class PropertyManager {

    public static final String industryRecordTypeId = '0125i000000pb7qAAA'; 
    public static final String officeRecordTypeId = '0125i000000pb80AAA';
    public static final String spaceRecordTypeId = '0125i000000pb7vAAA';
    
     public static List<Property__c> getPropertyByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Deal WHERE Id IN :ids');
   }


    public static Property__c createProperty(String name, Double salePrice, Double rentalPrice, String adress, 
        Id secondContact , Id type,  Boolean serialize){
       	
        Property__c prop = new Property__c();
        prop.Name = name;
        prop.Price__c = salePrice;
        prop.Rental_price__c = rentalPrice;
        prop.Address__c = adress;
        prop.Second_Contact__c = secondContact;
        prop.RecordTypeId = type;
        
        if (serialize) insert prop;

       	return prop;
    }
    
   public static Property__c updatePropertyByName(String searchName, String name, Double salePrice, Double rentalPrice, 
    String adress, Id type,  Boolean serialize){
    Property__c queriedProp = [SELECT Name, Price__c, Rental_price__c, Address__c, RecordTypeId FROM Property__c WHERE Name=:searchName];
        Property__c prop = new Property__c();
        queriedProp.Name = name;
        queriedProp.Price__c = salePrice;
        queriedProp.Rental_price__c = rentalPrice;
        queriedProp.Address__c = adress;
        queriedProp.RecordTypeId = type;
        
        if (serialize) update queriedProp;
        
    	return queriedProp;
    }
    
    public static void deletePropertyByTypes(List<String> typesId) {
    	delete [SELECT Id FROM Property__c WHERE RecordTypeId IN :typesId];
    }
}
