public inherited sharing class PropertyManager {

    public static final String industryRecordTypeId = '0125i000000pb7qAAA'; 
    public static final String officeRecordTypeId = '0125i000000pb80AAA';
    public static final String spaceRecordTypeId = '0125i000000pb7vAAA';
    
     public static List<Property__c> getPropertyByIds(List<Id> ids, String fields) {
       return Database.query('SELECT ' + fields + ' FROM Deal WHERE Id IN :ids');
   }


       public PropertyWrapper(Decimal price, Decimal rentalPrice, Contact owner, LocationWrapper locationWrapper) {
        this.price= price;
        this.rentalPrice = rentalPrice;
        this.owner = owner.Id;
        this.location = new Location_Wrapper__c();
        this.location.Address__c = locationWrapper.address;
        this.location.City__c = locationWrapper.city;
        this.location.Country__c = locationWrapper.country;
        this.location.Longitude__c = String.isBlank(locationWrapper.longitude) ? '' : locationWrapper.longitude;
        this.location.Latitude__c = String.isBlank(locationWrapper.latitude) ? '' : locationWrapper.latitude;
        insert location; 
    }       


        public class LocationWrapper{
        public String city {get; set;}
        public String country {get; set;}
        public String address {get; set;}
        public String latitude {get; set;}
        public String longitude {get; set;}
        public LocationWrapper(String city, String country, String address, String latitude, String longitude) {
            this.city = city;
            this.country = country;
            this.address = address;
            this.latitude = latitude;
            this.longitude = longitude;
        }
    }

        public static Property__c createProperty(PropertyWrapper wrapper, Boolean serialize) {
        Property__c property = new Property__c();
        property.Price__c = wrapper.priceSold;
        property.Rental_Price__c = wrapper.rentalPrice;
        property.Owner_Contact__c = wrapper.owner;
        property.Location_Wrapper__c = wrapper.location.Id;

        if (serialize) insert property;

        return property;
    }
       public static Property__c updatePropertyByName(String searchName, String name, Double salePrice, Double rentalPrice, 
        String adress, Id type,  Boolean serialize){
        Property__c queriedProp = [SELECT Name, Price__c, Rental_Price__c, Address__c, RecordTypeId FROM Property__c WHERE Name=:searchName];
            Property__c prop = new Property__c();
            queriedProp.Name = name;
            queriedProp.Price__c = salePrice;
            queriedProp.Rental_Price__c = rentPrice;
            queriedProp.Address__c = adress;
            queriedProp.RecordTypeId = type;

            if (serialize) update queriedProp;

            return queriedProp;
        }

        public static void deletePropertyByTypes(List<String> typesId) {
            delete [SELECT Id FROM Property__c WHERE RecordTypeId IN :typesId];
        }

        public static List<Property__c> getPropertiesByOwners(List<Id> ownersIds, String fields) {
            return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Property_Owner__c IN :ownersIds');
        }
}
