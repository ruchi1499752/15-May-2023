public class customClass1{
    public String currentRecordId{get;set;}
    public Account acc{get;set;}
    
    public customClass1(){
       currentRecordId = ApexPages.CurrentPage().getparameters().get('id');
        acc = [Select name,Industry,id,Rating from Account where id =: currentRecordId limit 1];
               
    }
    public Account getAccount() {
        return acc;
    }
}