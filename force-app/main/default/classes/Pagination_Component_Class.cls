/* ---------------------------------------------------------------------------------------------------------------------------
* Description   :   Controller (Child Component Controller) This Controller is used to Implement Pagination.
* Created By    :   Ruchi Chourasia
* Created Date  :   
-------------------------------------------------------------------------------------------------------------------------------*/

public class Pagination_Component_Class {

    public String qry{get;set;}  
    public String obj{get;set;} 
    public String obj1{get;set;} 
    
    public String fields{get;set;}
    public String fields1{get;set;}

    public List<sobject> myData{get;set;} //get record
    
    public List<String> selectedFields{get;set;}
    
    
   // public List<SelectOption> fieldLabel{get;set;}
    
    public ApexPages.StandardSetController std{get;set;}

    public integer RecordsPerPageslist{get;set;}
   	public List<SelectOption> options{get;set;}
    public Integer PageNumber{get;set;}
    
    public String sortDirection{get;set;}
  	public String fieldName{get;set;}
   	public boolean showData{get;set;}

    public List<wrapperClass> wrapList{get;set;}
    
/* Constructor
    
*  @description    :   Set the Value of Variables
*  @args           :   No arguments
*  @return         :   void

*/  
    
    public Pagination_Component_Class(){
        showData = false;
        RecordsPerPageslist=10;
        sortDirection = 'DESC';
        
        
        myData = new List<sobject>();
        selectedFields = new List<String>();
        alphabet = new List<String>();
        wrapList = new List<wrapperClass>();
        ids = new List<id>();

		options = new list<SelectOption>();
        options.add(new SelectOption('5','5'));
        options.add(new selectOption('10','10'));
        options.add(new selectOption('15','15'));
        options.add(new selectOption('20','20'));
	}
    
/* Method
    
*  @description    :   thid method is used to display records
*  @args           :   No arguments
*  @return         :   void

*/  

    public void displayData(){
        selectedFields.clear();
        wrapList.clear();
        
        obj1 = obj;
        fields1 = fields;
        
        selectedFields.clear();
        showData = true;
        
        qry = 'Select ' + fields1 + ' FROM ' + obj1;
        System.debug(qry);
        myData = Database.query(qry);

        //selectedFields.clear();
        selectedFields.addAll(fields1.split(','));
        System.debug('Selected Fields: ' + selectedFields);
        
      	std = new ApexPages.StandardSetController(Database.query(qry));

        std.setPageSize(RecordsPerPageslist);		//setPageSize: Sets the number of records in each page set.
		myData = std.getRecords();					//getRecords: Returns the list of sObjects in the current page set

        for(SObject obj : myData){
            wrapList.add(new wrapperClass(obj,false));
        }
    }
    
/* Constructor
    
*  @description    :   To display a list of alphabets on vf page 
*  @args           :   No arguments
*  @return         :   List of String

*/  
    
    public list<String> alphabet{
        
        get{                                                   
            alphabet = new list<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Others','All'};
                return alphabet;         
                }
        set;

	}
    public String alphaSearchRecord{get;set;}                                                    // To get commandlink parameter for alphabet selected
	public void alphaSearch(){                                                              //To update contact list as per the alphabet selected by the user

        if (alphaSearchRecord =='All'){
            
            qry = 'Select ' + fields + ' FROM ' + obj;
            //myData = database.query(qry);
            System.debug('All : '+ qry);
            std = new ApexPages.StandardSetController(Database.query(qry));
            std.setPageSize(RecordsPerPageslist);
            fetchRecords();


            
        }
        else if(alphaSearchRecord == 'others'){
           // qry = 'Select ' + fields + ' FROM ' + obj + ' WHERE '+ fields+ ' Like \' %[^a-z A-Z]%\'';
            //myData = database.query(qry);
           
        }else{
            qry = 'Select ' + fields + ' FROM '+ obj +' WHERE '+ fieldname +' like \''+alphaSearchRecord+'%\'';
            system.debug(qry);
            std = new ApexPages.StandardSetController(Database.query(qry));
        	std.setPageSize(RecordsPerPageslist);
			fetchRecords();

        }
            
        
	}


    public void changePageNumber(){
        
		fetchRecords();
    }
    
    /* Change and fetch Number Of Records Shown Per Page */
    public void updateRecordSize(){
        std.setPageSize(RecordsPerPageslist); 
        fetchRecords();
    }
    
/* Method
      
*  @description    :   This method is used for column wise Sorting
*  @args           :   No arguments 
*  @return         :   Void

*/
	public void sortExpression(){
        if(sortDirection == 'ASC'){
            sortDirection = 'DESC';
        }
        else{
            sortDirection = 'ASC';
        }
       	qry = 'Select ' + fields + ' FROM ' + obj+ ' order by '+ fieldName +' '+ sortDirection ;	
        System.debug(qry);
        std = new ApexPages.StandardSetController(Database.query(qry));
        std.setPageSize(RecordsPerPageslist);
          
       	myData = std.getRecords();
        wrapList.clear();
        for(SObject obj : myData){
            if(ids.contains(obj.Id)){
                wrapList.add(new wrapperClass(obj,true));
            }
            else{
                wrapList.add(new wrapperClass(obj,false));
            }
        }
            
    }

    public void first(){
        std.first();
        maintainState();
        fetchRecords();
        
    }
    public void pre(){
        std.previous();
        maintainState();
        fetchRecords();
       
    }
    public void next(){
        std.next();
        System.debug('Next Button');
        maintainState();
        fetchRecords();
        
    }
    public void last(){
        System.debug('Last Button');
        std.last();
        maintainState();
        fetchRecords();
        
    }

    public void fetchRecords(){
        myData = std.getRecords();
        wrapList.clear();
        for(SObject obj : myData){
            if(ids.contains(obj.Id)){
                wrapList.add(new wrapperClass(obj,true));
            }
            else{
                wrapList.add(new wrapperClass(obj,false));
            }
        }
    }
   
/* Inner Class : used to Store Record and its Checkbox Value */    
    public class wrapperClass{
        public Boolean selcetedCheckBox{get;set;}
        public SObject rec{get;set;}
       
        public wrapperClass(SObject rec, Boolean selcetedCheckBox){
            this.rec = rec;
            this.selcetedCheckBox = selcetedCheckBox;           

        }
        public wrapperClass(){
            
        }
        
    }

/* Constructor
                    
*  @description    :   This methods is used for maintain chechbox state
*  @args           :   No arguments
*  @return         :   void
                
*/
    
    List<id> ids{get;set;}
    public void maintainState(){
        
        for(wrapperClass w : wrapList){
            System.debug(w);
           if(w.selcetedCheckBox == true){
                ids.add(w.rec.Id);
               System.debug(ids);

            }
        }
    }
 
/* Constructor
                    
*  @description    :   This methods is used to delete Selected records
*  @args           :   No arguments
*  @return         :   void
                
*/    
    public void deleteSelectedRecords(){
        
        try{
            List<id> selectdelRec = new List<id>();
            List<WrapperClass> notSelectedItems = new List<WrapperClass>();
            if(selectdelRec.isEmpty()){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one record'));
            }
        	for(WrapperClass del : wrapList){
                if(del.selcetedCheckBox == true){
                    selectdelRec.add(del.rec.Id);
                    System.debug(selectdelRec);
                }
                else{
                    notSelectedItems.add(del);
                    /*if(selectdelRec.isEmpty()){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one record'));
                    }*/
                }
                
        	}
            wrapList.clear();
            wrapList.addAll(notSelectedItems);

                database.delete(selectdelRec);
                System.debug('Record Deleted');
                selectdelRec.clear();
                System.debug(selectdelRec);
              
    
        }

        catch(Exception ep){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ep.getMessage()));
            System.debug(ep);
        }
    }
    
    
/* Method
      
*  @description    :   This method is used for Download CSV File of Selected Records
*  @args           :   No arguments 
*  @return         :   Void

*/

    public String csv{get;set;}

    public void CreateCsvfiles(){
        List<SObject> selectFlds = new List<SObject>();

        for(wrapperClass w : wrapList){
            System.debug(w);
           if(w.selcetedCheckBox == true){
            selectFlds.add(w.rec);
            System.debug(selectFlds);
            }
            else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one record'));
            }

        }

            csv = fields + '\\n';
            for(SObject res : selectFlds){
                
                csv += String.valueOf(res)+ '\\n';
                
            }  
            System.debug('Final Query : ' + csv);
    }
    
}