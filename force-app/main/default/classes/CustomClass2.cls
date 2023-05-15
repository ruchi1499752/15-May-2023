public class CustomClass2 {
    public Position__c pos{get;set;}
    
    //getter and setter is used to access the position object on vs page. 
    
    public CustomClass2(){
       pos = new Position__c(); 
    }
   
    public PageReference saveRecord(){
        insert pos;
        //PageReference is object in the salesforce, It is use to  navigate the user to a different page or Url as the result of an action method.
        // Send the user to the detail page for the new account.
        PageReference pg = new ApexPages.StandardController(pos).view();
        pg.setRedirect(true);
      	return pg;
    }
    public void  quick(){
        insert pos;
    }
    public PageReference cancel(){
        PageReference pageRef = new PageReference('https://briskminds87-dev-ed.my.salesforce.com/home/home.jsp');
        pageRef.setRedirect(true);
       	return pageRef;
    }
    
}