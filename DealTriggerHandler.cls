public class DealTriggerHandler extends TriggerHandler {
	  
  public override void afterUpdate() {
      //String propName = '';
      Boolean check;
      for(Deal__c dl : (List<Deal__c>)Trigger.New) {
          //propName = dl.Name;
          if (dl.Status__c == 'Closed Won'){
              check = true;
          }
        } 
      if (check == true){
        List<Deal__c> dealToChange = [SELECT Id FROM Deal__c WHERE (Id IN : Trigger.New) 
                                      AND (Status__c = 'Open' OR Status__c = 'Awaiting approval')];
       
        for(Deal__c dl : dealToChange) {
            
            dl.Status__c = 'Closed Lost';
        }
          
        update dealToChange; 
      }
  }
    
}