@IsTest
public class ContactManagerTest {
    
    @IsTest static void getContactsbyIdTest(){      
        Contact con = new Contact();       
        
        list<Id> ids = new list<Id>();
        //TestContact Id
        ids.add('0035i00000BVfiXAAT');
        list<Contact> conTest = ContactManager.getContactsByIds(ids, 'Name');
        System.debug(conTest);
   
    }
    
    @IsTest static void createContactTest(){
        Contact con = new Contact();
        con = ContactManager.createContact('firstName', 'lastName', 'phone', '0125i000000pa23', true);
       
    }
    
  
   
	@IsTest static void updateContactByNameTest(){
       Contact con = new Contact();
       con = ContactManager.updateConByName('Alan Pall', 'firstName', 'lastName', 'phone', true);

    }
    
   
    @IsTest static void deleteContactsByNameTest() {
		list<String> names = new list<String>();
        names.add('Alan Pall');
        ContactManager.deleteContactsByName(names);
        list<Contact> con = [SELECT Id FROM Contact WHERE Name IN :names];
        System.assertEquals(con, null);
    }
    
    
}
