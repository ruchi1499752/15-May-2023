public class accClass {
    list <Account> l = new List<Account>();
    
    public accclass(){
        /*for(integer i=0;i<10;i++)
        {
            Account a = new Account(Name = 'Demo1-'+i);
            l.add(a);
        }
        Database.insert(l);*/
        
        
        /*Integer count = 0;
        for(Account acc: [Select Name from Account where Name like 'Demo1%']){
            count++;
        }
        System.debug('count 1: '+count);  */
        
        Integer count = 0;
        for(Account[] accList: [Select Name from Account where Name like 'Demo%']){
            System.debug('list size = '+accList.size());  
            count++;
        }
        System.debug('count 2: '+count);
    }
    
    
    
    
}