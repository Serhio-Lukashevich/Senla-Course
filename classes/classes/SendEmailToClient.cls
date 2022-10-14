public class SendEmailToClient{
    public static void sendEmail(List<Deal__c> deal){
		Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
         for (Deal__c dl : deal) {
                    List<String> sendTo = new List<String>();
              		sendTo.add(dl.Buyer_Contact__r.Email);         
             		mail.setSenderDisplayName(dl.Seller_Contact__c);           
                    mail.setCcAddresses(sendTo);

              		mail.setSubject('Notification');
              		String body = 'Dear ' + dl.Buyer_Contact__r.Name + ', ';
              		body += 'The lease expires tomorrow';
              		body += 'We ask you to leave the premises before noon the next day';
              		mail.setHtmlBody(body);    
         }
    }
}