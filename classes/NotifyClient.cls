public class NotifyClient implements Database.Batchable<sObject>{


  public Database.QueryLocator start(Database.BatchableContext bc) {
       return Database.getQueryLocator([SELECT Id FROM Deal__c 
                                        WHERE RecordTypeId = '00h5i0000066HM6AAM'
                                        AND End_Of_The_Lease__c = TOMORROW]);
  }

   public void execute(Database.BatchableContext bc, List<Deal__c> deals){
       List<Deal__c> dlList = [SELECT Id, End_Of_The_Lease__c, Buyer_Contact__c FROM Deal__c 
                               WHERE RecordTypeId = '00h5i0000066HM6AAM'
                   AND End_Of_The_Lease__c = TOMORROW];
       
           if(dlList.size() > 0) {
               for (Deal__c dl : dlList) {
                   NotifyClientRentEnding__e e = new NotifyClientRentEnding__e();
                   EventBus.publish(e);
                   SendEmailToClient.sendEmail(dl);
                   e.DealId__c = dl.Id;                   
                   e.Info__c = infoJSON.makeJSON(dl);
                  
               }
           }
   }

   public void finish(Database.BatchableContext bc){}
}