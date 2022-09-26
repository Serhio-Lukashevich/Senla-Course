@IsTest
public class LogManagerTest {
    @IsTest static void getLogsbyIdTest(){
        list<Id> ids = new list<Id>();
        ids.add('a005i000009Z5spAAC');
        //public static void getRecordByIdTest('a005i000009Z5spAAC')
        list<Log__c> mes = LogManager.getLogsByIds(ids, 'Message');
        list<Log__c> log = new list<Log__c>();
        System.assertEquals(mes, log);
    }
    
    @IsTest static void createLogsTest(){
       Log__c log = new Log__c();
       log = LogManager.createLog('TestLog31', 'testMessage', 'type', true);
       
    }
    
      @IsTest static void updateLogByNameTest(){
       Log__c log = new Log__c();
       log = LogManager.updateLogByName('TestLog31', 'TestLog212', 'testMessage', 'type', true);
       System.debug(log);
    }
    
    
}