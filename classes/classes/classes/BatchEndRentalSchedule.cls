public class BatchEndRentalDealSchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        Database.executeBatch(new BatchEndRentalDeal());
    }
}