@IsTest public class TestDataFactory {
    public static final Integer STATUS_CODE_200 = 200;
   public static final Integer STATUS_CODE_404 = 404;
   public static final String COUNTRY_FROM_PHONE_BODY_BELARUS = '[{"name":"Belarus","topLevelDomain":[".by"]';
   public static final String BELARUS = 'Belarus';
   public static final String RU = 'ru';
   public static final String EN = 'en_US';
   public static final Id TEST_ADDRESS_ID = [SELECT Id FROM Property__c WHERE Name = 'Burlington evaluation' LIMIT 1].Id;
   public static final Id TEST_SECOND_CONTACT_ID = [SELECT Id FROM Deal_Contact__c WHERE Name = 'Patrick' LIMIT 1].Id;
   public static final Id TEST_BROKER_ID = [SELECT Id FROM Contact WHERE Name = 'Arnold Hoffington' LIMIT 1].Id;
   public static final Id TEST_PROPERTY_ID = [SELECT Id FROM Property__c WHERE Name = 'Burlington evaluation' LIMIT 1].Id;
   public static final Id TEST_SELLER_ID = [SELECT Id FROM Contact WHERE Name = 'Rony Adams' LIMIT 1].Id;
   public static final Id SALES_DEP_PROFILE_ID = [SELECT Id FROM Profile WHERE Name = 'Sales Department' LIMIT 1].Id;
   public static final Id CLIENT_PROFILE_ID = [SELECT Id FROM Profile WHERE Name = 'FasTTransfer Client' LIMIT 1].Id;
   public static final Id SALES_MANAGER_ROLE =
           [SELECT Id FROM UserRole WHERE DeveloperName = 'Sales_Manager' LIMIT 1].Id;
   public static final User SALES_MANAGER = [SELECT Id FROM User WHERE Profile.Name = 'Sales Department' LIMIT 1];

   
   
   public static Log__c createLog(String name) {
       Log__c log = new Log__c(Name = name);
       insert log;
       return log;
   }   
   
   
   public static Deal__c createDeal(String status, Id type) {
       Deal__c dl = new Deal__c();
           dl.Property__c = TEST_PROPERTY_ID;
           dl.Seller_Contact__c = TEST_SELLER_ID;
           dl.Broker__c = TEST_BROKER_ID;
           dl.Status__c = status;
           dl.RecordTypeId = type;
       insert dl;
       return dl;
   }
   
   public static Property__c createProperty(String name, Double salePrice, Double rentalPrice,  Id type){
       Property__c prop = new Property__c();
           prop.Name = name;
           prop.Price__c = salePrice;
           prop.Rental_price__c = rentalPrice;
           prop.Address__c = TEST_ADDRESS_ID;
           prop.Second_Contact__c = TEST_SECOND_CONTACT_ID;
           prop.RecordTypeId = type;
       insert prop;
          return prop;
   }
   
   
   public static User createSalesDepartmentUser(String name, String language) {
       User user = new User(LastName = name, LanguageLocaleKey = language, Username = name + '@username.com',
               Email = name + '@test.com', Alias = name, TimeZoneSidKey = 'Europe/Minsk',
               LocaleSidKey = language, EmailEncodingKey = 'UTF-8', ProfileId = SALES_DEP_PROFILE_ID,
               UserRoleId = SALES_MANAGER_ROLE);
       insert user;
       return user;
   }

   public static User createClientUser(Contact contact) {
       User user = new User(ProfileId = CLIENT_PROFILE_ID, ContactId = contact.Id, LastName = contact.LastName,
               LanguageLocaleKey = EN, Username = contact.LastName + '@username.com',
               Email = contact.LastName + '@test.com', Alias = 'abc',
               TimeZoneSidKey = 'Europe/Minsk', LocaleSidKey = EN, EmailEncodingKey = 'UTF-8');
       System.debug('Client user = ' + user);
       insert user;
       return user;
   }

   public static Account createAccount(String name) {
       Account acc = new Account(Name = name);
       insert acc;
       return acc;
   }

   public static Account createAccount(String name, Id ownerId) {
       Account acc = new Account(Name = name, OwnerId = ownerId);
       insert acc;
       return acc;
   }

   public static Contact createContact(Account account, String lastName, String email) {
       Contact contact = new Contact(Account = account, AccountId = account.Id, LastName = lastName,
               Email = email);
       insert contact;
      return contact;
   }


   public static List<Contact> createContacts(Integer num) {
       List<Contact> contacts = new List<Contact>(num);
       for (Integer i = 0; i < num; i++) {
           contacts[i] = new Contact(LastName = 'Test' + i, Phone = '+375-29-1234567');
       }
       insert contacts;
       return contacts;
   }

   public static Contact createContact(String lastName, String phone) {
       Contact c = new Contact(LastName = lastName, Phone = phone);
       insert c;
      return c;
   }

 
   public static List<Lead> createLeads(Integer num) {
       List<Lead> leads = new List<Lead>(num);
       for (Integer i = 0; i < num; i++) {
           leads[i] = new Lead(LastName = 'Test' + i, Phone = '+375-29-1234567', Company = 'Test');
       }
       insert leads;
       return leads;
   }

   public static Lead createLead(String lastName, String phone) {
       Lead l = new Lead(LastName = lastName, Phone = phone, Company = 'Test');
       insert l;
      return l;
   }

   public static Lead createLead(String lastName, String email, Id owner) {
       Lead l = new Lead(LastName = lastName, Company = 'Test', Email = email, OwnerId = owner);
       insert l;
       return l;
   }

   

}