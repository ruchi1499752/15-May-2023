public class InnerClassDemo1 {
    
    public static DataWrapper getLists(){
        DataWrapper res = new DataWrapper();
        //System.debug('===>'+ res);
        return res;
       // return new DataWrapper();
    }
    
    public class DataWrapper{
        List<Account> accList;
        List<Contact> conList;
        
        public DataWrapper(){
            List<Account> accList = [SELECT Name, Id FROM Account];
        	List<Contact> conList = [SELECT LastName, Id FROM Contact];
            
            System.debug('accList :' + accList);
            for(Account acc : accList){
                System.debug('NAme :' + acc.Name);
            }
        }
        
    }
}