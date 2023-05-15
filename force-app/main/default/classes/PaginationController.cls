/*---------------------------------------------------------------------------------------------------------------------------------------------------------------
* Description   :   Controller (PaginationController) This Controller is used to Get Objects and Fields According to Selected Object(Using Schema Class)
* Created By    :   Ruchi Chourasia
* Created Date  :   
-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/

public class PaginationController {
    public boolean render{get;set;}
    public Boolean showTable{get;set;}
   

    public Map<String,Schema.SobjectType> objectMap{get;set;}
    public String selectedObject{get;set;}
    public String selectedObj{get;set;}
    public List<SelectOption> sObjectList{get;set;}

    
    public Map<String,Schema.SobjectField> fieldMap{get;set;}
    public List<String> fieldList{get;set;}
    
    public List<SelectOption> fnsoption{get;set;}
    public List<string> sfields{get;set;}
    public List<SelectOption> fsoption{get;set;}
    public List<String> rfields{get;set;}
    
    
    
    public String qry{get;set;}
    public List<sobject> myData{get;set;}
    public String stringFieldNames{get;set;}
    public String stringFldNames{get;set;}
    public List<String> myfields{get;set;}
    

/* Constructor
    
*  @description    :   This constructer is used to Get the Objects List and add in PickList 
*  @args           :   No arguments
*  @return         :   void

*/      
    public PaginationController(){
        render = false;
        showTable = false;
        
		
        sObjectList = new List<SelectOption>();

        sObjectList.add(new SelectOption('None','---None---'));
        objectMap = Schema.getGlobalDescribe();
        
        List<String> standardObjectList = new List<String>();
        standardObjectList.addAll(objectMap.keySet());
        Schema.DescribeSObjectResult[] objName = Schema.describeSObjects(standardObjectList);
        
        sObjectList.add(new SelectOption('Account','Account'));
        sObjectList.add(new SelectOption('Asset','Asset'));
        sObjectList.add(new SelectOption('Case','Case'));
        sObjectList.add(new SelectOption('Campaign','Campaign'));
        sObjectList.add(new SelectOption('Lead','Lead'));
        sObjectList.add(new SelectOption('Opportunity','Opportunity'));
        sObjectList.add(new SelectOption('Contract','Contract'));
        sObjectList.add(new SelectOption('idea','idea'));
        sObjectList.add(new SelectOption('Product2','Product2'));
        sObjectList.add(new SelectOption('Order','Order'));
        sObjectList.add(new SelectOption('Solution','Solution'));
        sObjectList.add(new SelectOption('User','User'));
        
        for(Schema.DescribeSObjectResult res : objName){
            //System.debug(res);
            if(res.isCustom()){
                sObjectList.add(new SelectOption(res.getName(), res.getLabel()));
            }
        }
        //sObjectList.sort();
        
        fieldList = new List<String>();
        fsoption = new List<SelectOption>();
        fnsoption = new List<SelectOption>();
        rfields = new List<String>();
        sfields = new List<String>();
        myData = new List<sobject>();
        myfields = new List<String>();
        
    }
    
    /*public void objectsList(){
       
        objectMap = Schema.getGlobalDescribe();
               
        sObjectList.add(new SelectOption('Account','Account'));
        sObjectList.add(new SelectOption('Asset','Asset'));
        sObjectList.add(new SelectOption('Case','Case'));
        sObjectList.add(new SelectOption('Campaign','Campaign'));
        sObjectList.add(new SelectOption('Lead','Lead'));
        sObjectList.add(new SelectOption('Opportunity','Opportunity'));
        sObjectList.add(new SelectOption('Contract','Contract'));
        sObjectList.add(new SelectOption('idea','idea'));
        sObjectList.add(new SelectOption('Product2','Product2'));
        sObjectList.add(new SelectOption('Order','Order'));
        sObjectList.add(new SelectOption('Solution','Solution'));
        sObjectList.add(new SelectOption('User','User'));
        
        List<String> standardObjectList = new List<String>();
        standardObjectList.addAll(objectMap.keySet());
        System.debug(standardObjectList);
        
        Schema.DescribeSObjectResult[] objName = Schema.describeSObjects(standardObjectList);

        
        for(Schema.DescribeSObjectResult res : objName){
            if(res.isCustom()){
                sObjectList.add(new SelectOption(res.getName(), res.getLabel()));
            }
        }
		//sObjectList.sort();

    }*/
    
/** Method
      
*  @description    :   This method is used to add Fileds in Picklist According To Selected Object
*  @args           :   No arguments 
*  @return         :   void

**/    
    
    public void fieldNames(){
        render = true;
        showTable = false;
        fieldList.clear();
        fnsoption.clear();
        fsoption.clear();
        rfields.clear();
        sfields.clear();
        //fieldList.clear();
        //fieldMap = objectMap.get(selectedObject).getDescribe().fields.getMap();
        //fieldList.addAll(fieldMap.keySet());
          
         schema.SObjectType obj = objectMap.get(selectedObject);

         //fnsoption = new List<SelectOption>();
        
         Schema.DescribeSObjectResult res = obj.getDescribe();
         fieldMap = res.fields.getmap();	
         fieldList.addAll(fieldMap.keySet());	
        
        for(String s  : fieldList){
            Schema.DescribeFieldResult fieldResult = fieldMap.get(s).getDescribe();
            if(fieldResult.isAccessible() && fieldResult.isSortable() && fieldResult.isFilterable())
            fnsoption.add(new SelectOption(s,fieldMap.get(s).getDescribe().getLabel()));
        }
		fnsoption.sort();
        fieldList.clear();
        
    }

/** Method
      
*  @description    :   This method is used to add Selected Fields in another Picklist
*  @args           :   No arguments 
*  @return         :   void

**/  
    
    public void addFields(){
      
        System.debug(fieldMap);
        for(String str : sfields){
            fsoption.add(new SelectOption(str,fieldMap.get(str).getDescribe().getLabel())); //2nd list
        }
        system.debug(fsoption);
        system.debug('1st list : ' + fnsoption.size());
        system.debug('2nd list :  ' + fsoption.size());
        
        for(Integer i=0 ; i<fnsoption.size(); i++){
            for(Integer j=0; j<fsoption.size(); j++){
                if(fnsoption[i] == fsoption[j]){
                    fnsoption.remove(i);	//remove(index) : Removes the list element stored at the specified index, returning the element that was removed.
                }
            }
        }
        fnsoption.sort();
        fsoption.sort();
        
       
        
    }
    
 /** Method
      
*  @description    :   This method is used to remove Selected Fields from Picklist
*  @args           :   No arguments 
*  @return         :   void

**/    
    public void removeFields(){
        for(String remo : rfields){
            fnsoption.add(new SelectOption(remo,fieldMap.get(remo).getDescribe().getLabel()));
        }

        for(Integer i=0 ; i<fsoption.size(); i++){
            for(Integer j=0; j<fnsoption.size(); j++){
                if(fsoption[i] == fnsoption[j]){
                    fsoption.remove(i);		//remove(index) : Removes the list element stored at the specified index, returning the element that was removed.
                }
            }
        }
        fnsoption.sort();
        fsoption.sort();
        
        
   	}

/** Method
      
*  @description    :   This method is used to reset the Page
*  @args           :   No arguments 
*  @return         :   PageReference

**/    
    public PageReference reset() {
       /* fsoption.clear();
        fnsoption.clear();
       showTable = false;*/
       // sObjectList = new List<SelectOption>();
        //sObjectList.add(new SelectOption('None','---None---'));
        //objectsList();*/
        
        
        PageReference page = ApexPages.currentPage();
        page.setRedirect(true);
        return page;
        
       
        //return null;
    }

/** Method
      
*  @description    :   This method runs when the process button is clicked.
*  @args           :   No arguments 
*  @return         :   void

**/     
    public void showData(){
        selectedObj = null;
        stringFldNames = null;
        
        List<String> selectedfields = new List<String>();
        selectedfields.clear();

        for(SelectOption op : fsoption){
            selectedfields.add(op.getValue());

        }
       stringFieldNames = String.join(selectedfields, ',');
       System.debug('selected fields in list: ' + stringFieldNames);

       if(selectedObj == null && stringFldNames == null ){
             stringFldNames = stringFieldNames;
             selectedObj = selectedObject;
             showTable = true;
       }

       system.debug(stringFldNames);
       system.debug(selectedobj);


       
    }
    
    public Boolean getdisableAddButton(){
        if(fnsoption.isEmpty()){    //1st list is empty : Returns true if the list has zero elements.
            return true;
        }else{
            return false;
        }

    }

    public Boolean getdisableRemoveButton(){

        if(fsoption.isEmpty()){     // 2nd list is empty : Returns true if the list has zero elements
            return true;
        }else{
            return false;
        }

    }

    public Boolean getdisableProcessButton(){
        if(fsoption.isEmpty()){     // 2nd list is empty : Returns true if the list has zero elements
            return true;
        }else{
            return false;
        }
    }
    
    
    
    //==========================================================================================================
	/*public Map<String, Schema.SObjectType> sc = Schema.getGlobalDescribe();
    public List<selectOption> objName{get;set;}
    public String selectObj{get;set;}
    public String selectField{get;set;}
    
    
    
    public PaginationController(){
        selectObj = 'Account';
        objName = new List<SelectOption>();
        List<String> key = new List<String>(sc.keySet());
       	key.sort();
        
        for(String nm : key){
            
            objName.add(new selectOption(nm,nm));
           	
        }

    }
    public void ObjectNames(){
       	objName = new List<SelectOption>();
        List<String> key = new List<String>(sc.keySet());
       	key.sort();
        
        for(String nm : key){
            
            objName.add(new selectOption(nm,nm));
           	
        }
        //return objName;
        
       	
    }
    public List<selectOption> getObjectFields(){
        Map<String, Schema.SObjectType> sc = Schema.getGlobalDescribe();
        Schema.sObjectType f = sc.get(selectObj);
        Map<String, Schema.SObjectField> fieldMap = f.getDescribe().fields.getMap();
        List<selectOption> fieldName = new List<selectOption>();
        for(String fnm : fieldMap.KeySet()){
            fieldName.add(new selectOption(fnm,fnm));
        }	
        return fieldName; 
    }*/
    
    /*Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
    for(Schema.SObjectType r : gd){
        System.debug(r);
    }*/
    
    
    
    
}