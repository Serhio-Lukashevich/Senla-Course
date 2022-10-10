public class InfoJSON {
    public static String makeJSON(Deal__c dl){
		
        Client__c cl = new Client__c();
        
        cl.SfId__c = dl.Buyer_Contact__r.Id;
        cl.First_Name__c = dl.Buyer_Contact__r.FirstName;
        cl.Last_Name__c = dl.Buyer_Contact__r.LastName;
        cl.Email__c = dl.Buyer_Contact__r.Email;

        
        LocationWrapper__c locWrap =  new LocationWrapper__c();
        
        locWrap.Country__c = dl.Buyer_Contact__r.MailingCountry;
        locWrap.City__c = dl.Buyer_Contact__r.MailingCity;
        locWrap.Address__c = 'testAddress';


        Property__c prop = new Property__c();
        
        prop.SfId__c = dl.Buyer_Contact__r.Id;
        prop.Property_Owner__c = cl.Id;
        prop.Address__c = locWrap.Id;

        Info__c inf = new Info__c();
        
        inf.Create_Date__c = Datetime.now();
        inf.Rent_Start_Date__c = dl.Start_Of_The_Lease__c;
        inf.Rent_End_Date__c = dl.End_Of_The_Lease__c;
        inf.Client__c = cl.Id;
        inf.Property__c = prop.Id;

        String jsonInfo = JSON.serialize(inf);
        return jsonInfo;
    }
}