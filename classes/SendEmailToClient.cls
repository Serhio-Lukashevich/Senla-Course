public class SendEmailToClient{
    public static void sendEmail(Deal__c deal){
		Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                    List<String> sendTo = new List<String>();
              		sendTo.add(deal.Buyer_Contact__r.Email);
                    
                    mail.setReplyTo(deal.Buyer_Contact__r.Email);
             		mail.setSenderDisplayName(deal.Seller_Contact__c);           
                    mail.setCcAddresses(sendTo);

              		mail.setSubject('Notification');
              		String body = 'Dear ' + deal.Buyer_Contact__r.Name + ', ';
              		body += 'The lease expires tomorrow';
              		body += 'We ask you to leave the premises before noon the next day';
              		mail.setHtmlBody(body);    
    }
}