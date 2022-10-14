public class BatchEndRentalDeal implements Database.Batchable<sObject>{
    public static final String FIELDS = 'Id, CreatedDate'
                                        + ', Buyer_Contact__r.Id'
                                        + ', Buyer_Contact__r.FirstName'
                                        + ', Buyer_Contact__r.LastName'
                                        + ', Buyer_Contact__r.Email'
                                        + ', Seller_Contact__c.Id'
                                        + ', Seller_Contact__c.FirstName'
                                        + ', Seller_Contact__c.LastName'
                                        + ', Seller_Contact__c.Email' 
                                        + ', Property__r.Country__c'
                                        + ', Property__r.City__c'
                                        + ', Property__r.Address__c'
                                        + ', End_Of_The_Lease__c'
                                        + ', Start_Of_The_Lease__c';

    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date endLeaseDate = Datetime.now().addHours(3).addDays(1).date();
        return Database.getQueryLocator(
            'SELECT ' + FIELDS + ' FROM Deal__c WHERE Rental_end_date__c = :endLeaseDate'
        );
    }

    public void execute(Database.BatchableContext bc, List<Deal__c> deals){
        List<NotifyClientRentEnding__e> newsEventList = new List<NotifyClientRentEnding__e>();
        for (Deal__c dl : deals) {
            NotifyClientRentEnding__e ncrEvent = new NotifyClientRentEnding__e(
                DealId__c = dl.Id,
                Info__c = JSON.serialize(new WrappersJSON.InfoWrap(dl), true)
            );
            newsEventList.add(ncrEvent);
        }
        
        SendEmailToClient.sendEmail(deals);
        List<Database.SaveResult> results = EventBus.publish(newsEventList);
    }

    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        
        Log__c batchLog = new Log__c (
            Type__c = 'Batch Errors',
            Message__c = String.valueOf(job.NumberOfErrors)
        );

        insert batchLog;
    }
}