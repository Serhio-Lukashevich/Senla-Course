public class NotifyClientSchedule implements Schedulable{
    public void execute(SchedulableContext ctx) {
        Database.executeBatch(new NotifyClient(), 200);
        String sch = '0 0 6 * * *';
        System.schedule('Notify Clients ', sch, new NotifyClientSchedule());
    }
}
