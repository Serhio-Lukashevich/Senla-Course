@RestResource(urlMapping='/propery/v1/*')
global class PropertyRestService {
    @HttpGet
    global static String getProperty() {
        String response;
        String path = RestContext.request.requestURI.substringAfterLast('v1/');
        if (path.contains('by_owner?owner=')) {
            response = getPropertiesByOwner(path.substringAfterLast('by_owner?owner='));
        }
        else if (path.contains('report/')) {
            response = getDealsByTypesAndPeriod(path.substringAfterLast('report/').substringBefore('?'),
                    path.substringAfterLast('startDate=').substringBefore('&'),
                    path.substringAfterLast('endDate=').substringBefore('&'),
                    path.substringAfterLast('dealType='));
        }
        else response = 'Invalid path';
        return response;
    }

    @HttpPost
    global static Property__c createNewProperty() {
        PropertyManager.PropertyWrapper wrapper = (PropertyManager.PropertyWrapper)
                                                  JSON.deserialize(RestContext.request.requestBody.toString(),
                                                                   PropertyManager.PropertyWrapper.class); // Нигде не нашёл как это поместить в параметры метода
        return PropertyManager.createProperty(wrapper, true);
    }

    @HttpPut
    global static String upsertPropertyOwner() {
        SerializationWrappers.UpdatePropertyOwnerPUTWrapper wrapPut = (SerializationWrappers.UpdatePropertyOwnerPUTWrapper)
                                                                      JSON.deserialize(RestContext.request.requestBody.toString(),
                                                                      SerializationWrappers.UpdatePropertyOwnerPUTWrapper.class);
        Id ownerID = [SELECT Owner__c FROM Property__c WHERE Id = :wrapPut.propertyId].Owner__c;
        Contact owner = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id =:ownerID LIMIT 1];
        owner.Id = String.isNotEmpty(wrapPut.newOwner.sfId) ? wrapPut.newOwner.sfId : owner.Id;
        owner.FirstName = String.isNotEmpty(wrapPut.newOwner.firstName) ? wrapPut.newOwner.firstName : owner.FirstName;
        owner.LastName = String.isNotEmpty(wrapPut.newOwner.lastName) ? wrapPut.newOwner.lastName : owner.LastName;
        owner.Email = wrapPut.newOwner.email;
        upsert owner;
        return JSON.serialize(owner);
    }

    private static String getDealsByTypesAndPeriod(String propertyId, String startDate, String endDate, String dealType) {
        String fields = 'Id, RecordType.DeveloperName'
                        + ', Broker__r.Id'
                        + ', Start_Of_The_Lease__c'
                        + ', End_Of_The_Lease__c'
                        + ', Seller_Contact__r.Id'
                        + ', Seller_Contact__r.FirstName'
                        + ', Seller_Contact__r.LastName'
                        + ', Seller_Contact__r.Email'
                        + ', Seller_Contact__r.Id'
                        + ', Deal_Amount__c';
        Date startPeriod = Date.valueOf(startDate);
        Date endPeriod = Date.valueOf(endDate);
        List<Deal__c> deals = DealManager.getDealsByPeriodAndProperty(propertyId, startPeriod, endPeriod, dealType, fields);
        SerializationWrappers.Response response = new SerializationWrappers.Response(startPeriod, endPeriod, deals);
        return JSON.serialize(response, true);
    }

    private static String getPropertiesByOwner(Id ownerId) {
        String fields = 'Id, Owner_Contact__c, Price__c, Rent_Price__c, Location_Wrapper__r.Id,' +
                        'Location_Wrapper__r.Country__c, Location_Wrapper__r.City__c, Location_Wrapper__r.Address__c';
        List<Property__c> properties = PropertyManager.getPropertiesByOwners(new List<Id>{ownerId}, fields);
        List<PropertyManager.PropertyWrapper> props = new List<PropertyManager.PropertyWrapper>();
        for (Property__c property : properties) {
            PropertyManager.PropertyWrapper propertyWrapper = new PropertyManager.PropertyWrapper(property);
            props.add(propertyWrapper);
        }
        return JSON.serialize(props, true);
    }
}