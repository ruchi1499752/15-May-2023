//Display sObject Record on Visualforce Page Using Controller.
public class MyMerchandise {
    public List<Merchandise__c>merchandiseList{get;set;}
    
    public MyMerchandise(){
        merchandiseList= [Select id,Name,Job_Description__c,Price__c,Total_Inventory__c from Merchandise__c];
    }
}