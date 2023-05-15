public class ScheduleApexDemo implements Schedulable {
    public void execute(SchedulableContext sc){
        System.debug('Inside Execute Method');
        List<Account> accList = [Select id, name from account where createddate = Today];
        for(Account acc : accList){
            acc.name = 'Created Today' + acc.name;
        }
        update accList;
        
    }	
	
}