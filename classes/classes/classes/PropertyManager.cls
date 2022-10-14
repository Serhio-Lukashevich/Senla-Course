public inherited sharing class PropertyManager {
    public class PropertyWrapper{
        public Id id {get; set;}
        public Decimal priceSold {get; set;}
        public Decimal rentPrice {get; set;}
        public Id owner {get; set;}
        public Location_Wrapper__c location {get; set;}
        public PropertyWrapper(Property__c property) {
            this.Id = property.Id;
            this.priceSold = property.Price_Sold__c;
            this.rentPrice = property.Rent_Price__c;
            this.owner = property.Owner__c;
            this.location = property.Location_Wrapper__r;
        }
        public PropertyWrapper(Decimal priceSold, Decimal rentPrice, Contact owner, LocationWrapper locationWrapper) {
            this.priceSold = priceSold;
            this.rentPrice = rentPrice;
            this.owner = owner.Id;
            this.location = new Location_Wrapper__c();
            this.location.Address__c = locationWrapper.address;
            this.location.City__c = locationWrapper.city;
            this.location.Country__c = locationWrapper.country;
            this.location.Longitude__c = String.isBlank(locationWrapper.longitude) ? '' : locationWrapper.longitude;
            this.location.Latitude__c = String.isBlank(locationWrapper.latitude) ? '' : locationWrapper.latitude;
            insert location; // не уверен правильно ли добавлять инсерт в конструктор враппера, но иначе никак (
        }
        public PropertyWrapper() {

        }
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
        property.Price_Sold__c = wrapper.priceSold;
        property.Rent_Price__c = wrapper.rentPrice;
        property.Owner__c = wrapper.owner;
        property.Location_Wrapper__c = wrapper.location.Id;

        if (serialize) insert property;

        return property;
    }

    public static List<Property__c> getPropertiesByIds(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Id IN :ids');
    }

    public static List<Property__c> getPropertiesByOwners(List<Id> ownersIds, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Owner__c IN :ownersIds');
    }

    public static List<Property__c> updatePropertiesLocationsByIds(List<Id> ids, Location_Wrapper__c newLocationWrapper, Boolean serialize) {
        List<Property__c> propertiesToUpdate = [SELECT Location_Wrapper__c FROM Property__c WHERE id IN :ids];
        for (Property__c property : propertiesToUpdate) {
            property.Location_Wrapper__c = newLocationWrapper.Id;
        }

        if (serialize) update propertiesToUpdate;

        return propertiesToUpdate;
    }


    public static List<Property__c> updatePropertyOwnerByIds(List<Id> ids, Id newOwner, Boolean serialize) {
        List<Property__c> propertiesToUpdate = [SELECT Owner__c FROM Property__c WHERE id IN :ids];
        for (Property__c property : propertiesToUpdate) {
            property.Owner__c = newOwner;
        }

        if (serialize) update propertiesToUpdate;

        return propertiesToUpdate;
    }

    public static void deletePropertiesByLocations(List<Location_Wrapper__c> locations) {
        delete [SELECT Id FROM Property__c WHERE Location_Wrapper__c IN :locations];
    }
}
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
