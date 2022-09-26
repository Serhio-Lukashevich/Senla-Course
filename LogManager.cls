public inherited sharing class LogManager {
    
    public static List<Log__c> getLogsByIds(List<Id> ids, String fields) {
      return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Id IN :ids');
  }

   public static Log__c createLog(String name, String message, String type, Boolean serialize){
       Log__c log = new Log__c();
       log.Name = name;
       log.Message__c = message;
       log.Type__c = type;
       
       if (serialize) insert log;

          return log;
   }
   
  public static Log__c updateLogByName(String searchName, String newName, String newMessage, String newType, Boolean serialize){
   Log__c queriedLog = [SELECT Name, Message__c, Type__c FROM Log__c WHERE Name=:searchName];
       queriedLog.Message__c = newMessage;
       queriedLog.Name = newName;
       queriedLog.Type__c = newType;
       
       if (serialize) update queriedLog;
       
       return queriedLog;
   }
   
   public static void deleteLogsByTypes(List<String> types) {
       delete [SELECT Id FROM Log__c WHERE Type__c IN :types];
   }
   
   
       
}
