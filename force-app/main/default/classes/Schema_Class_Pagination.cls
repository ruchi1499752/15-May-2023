public class Schema_Class_Pagination {
	public String selectedObject{get;set;}
    public list<selectoption> sObjectList{get;set;}
    Map<String, Schema.SObjectType> allObjectMap;
    
    public list<string> fields1{get;set;}
    public list<selectoption> fieldsList{get;set;}
    Map<String, Schema.SObjectField> fieldMap;
    public list<string> selectFields{get;set;}
    public list<selectoption> selectedFieldsList{get;set;}
    integer i=0;

    public List<sObject> record {get;set;}
    public List<string> lstFlds {get;private set;}

 	Public Schema_Class_Pagination(){
        fieldsList = new list<selectoption>();
        selectedFieldsList = new list<selectoption>();

    	allObjectMap = Schema.getGlobalDescribe();
        sObjectList = new List<selectoption>();
    	for(string s:allObjectMap.keyset()){
            if(i<1000){
                sObjectList.add(new selectoption(s,s));  
                i++;
            }
            else{break;}
    	}
        sObjectList.sort();
	}

    public void field(){
		fieldMap = allObjectMap.get(selectedObject).getDescribe().fields.getMap();
        fieldsList = new List<selectoption>();
		for(String fieldName : fieldMap.keyset() )
    	{
        	fieldsList.add(new selectoption(fieldName,fieldName));
    	}   
        fieldsList.sort();
        reset1();
    }
    public void selectedField(){
        for(String sf : fields1 )
    	{   
            selectedFieldsList.add(new selectoption(sf,sf));
            System.debug('Selected fields : '+sf);
    	}  
        for(Integer i=0; i<fieldsList.size();i++){
            for(Integer j=0; j<selectedFieldsList.size();j++){
                if(fieldsList[i]==selectedFieldsList[j]){
                    fieldsList.remove(i);
                }
            }
        }
        selectedFieldsList.sort();
    }
    public void removedField(){
        for(String sf : selectFields )
    	{   
            fieldsList.add(new selectoption(sf,sf));
    	}  
        for(Integer i=0; i<selectedFieldsList.size();i++){
            for(Integer j=0; j<fieldsList.size();j++){
                if(selectedFieldsList[i]==fieldsList[j]){
                    selectedFieldsList.remove(i);
                }
            }
        }
        fieldsList.sort();
    }
    public PageReference reset(){
        fieldsList.clear();
        record.clear();
        reset1();
        return null;
    }
    public PageReference reset1(){
        selectedFieldsList.clear();
        return null;
    }
    public PageReference add(){
        selectedField();
        return null;
    }
    public PageReference remove(){
        removedField();
        record.clear();
        return null;
    }
    public Boolean getdisabledAdd(){
        if(fieldsList.isEmpty()){
            return true;
        }
        else{
            return false;
        }
    }
    public Boolean getdisabledRemove(){
        if(selectedFieldsList.isEmpty()){
            return true;
        }
        else{
            return false;
        }
    }
    public PageReference process(){
        String rec = 'Select ';
        for(SelectOption s:selectedFieldsList){
            rec=rec + s.getValue();
            SelectOption c = selectedFieldsList[selectedFieldsList.size()-1];
            if(c.getValue()!=s.getValue()){
                rec=rec + ', ';
            }
        }
        rec = rec + ' from ' + selectedObject;
        record=database.query(rec);
        lstFlds = new List<string>();
        lstFlds.addAll(record[0].getPopulatedFieldsAsMap().keySet());
        return null;
    }
}