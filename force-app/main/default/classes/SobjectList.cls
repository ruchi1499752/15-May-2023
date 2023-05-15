public class SobjectList {
    public Map<String,Schema.SobjectType> m{get;set;}
    public String selectedObject{get;set;}
    public List<SelectOption> sObjectList{get;set;}
    
    public Map<String,Schema.SobjectField> fieldMap{get;set;}
    public List<SelectOption> fieldList{get;set;}
    
    public List<string> sfields{get;set;}
    public List<String> rfields{get;set;}
    
    public Set<String> fSelected{get;set;}
    public Set<String> fnotselected{get;set;}
    
    public List<SelectOption> fsoption{get;set;}
    public List<SelectOption> fnsoption{get;set;}
    
    
    
   // public list<SelectOption> selectedFieldsList{get;set;}
   // public List<String> selectfields{get;set;}
   
    
    
    public SobjectList(){
        m = Schema.getGlobalDescribe();
        //==========================
        fSelected = new Set<String>();
        fnotselected = new Set<String>();
        fsoption = new List<SelectOption>();
        fnsoption = new List<SelectOption>();
       // fieldList = new List<SelectOption>();
        
        
        //=========================
        sObjectList = new List<SelectOption>();
        SelectOption op=  new SelectOPtion('None','---None---');
        sObjectList.add(op);
        for(String s : m.keySet()){   /* Get all the object names from the map */
            
            Schema.SobjectType obj = m.get(s);
            /* Fetch the description of the object */
            Schema.DescribeSObjectResult res = obj.getDescribe();
            /* Check weather object is a custom or not */
            if(res.isCustom()){
                sObjectList.add(new SelectOption(s,s));
            }
          
        }
        sObjectList.sort();
        
    }
    
    public void field(){
        fieldMap = m.get(selectedObject).getDescribe().fields.getMap();
        fieldList = new List<SelectOption>();
        for(String r :fieldMap.KeySet() ){
            //fieldMap.get(fieldMap).getDescribe().getLabel();//It provides to get the object fields label.
            fieldList.add(new SelectOption(r,r));
           // fieldMap.get(fieldMap).getDescribe().getLabel();
           // System.debug(r);
        }
        fieldList.sort();
        
        //fnotselected.addAll(fieldList);
        show();
        
        
    }
    public void show(){
        
       fnsoption.clear();
       fsoption.clear();
        for(String s1 : fnotselected){
            fnsoption.add(new SelectOption(s1,s1));
            
        }
        for(String s2 : fSelected){
            fsoption.add(new SelectOption(s2,s2));
        }
        
        
        
        
    }
    public void addFields(){
        fnotselected.removeAll(sfields);
        fSelected.addAll(sfields);
        show();
    }
    public void removeFields(){
        fnotselected.addAll(rfields);
        fSelected.removeAll(rfields);
        show();
        
        
    }
    
   /* public void checkSelectedField(){
        for(String sf : fields1){
            selectedFieldsList.add(new SelectOption(sf,sf));
            //System.debug('Selected fields : '+sf);
            
        }
        for(integer i = 0; i<fieldList.size(); i++){
            for(integer j = 0; j<selectedFieldsList.size(); j++){
                if(fieldList[i] == selectedFieldsList[j]){
                    fieldList.remove(i);
                }
            }
        }
    }
    public void add(){
        checkSelectedField();
    }*/
    
    
}