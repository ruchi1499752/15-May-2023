public class Schema_Class {
    public Map<String, Schema.SobjectType> m{get;set;}
    public List<String> objlist{get;set;}
    public String selectedObj{get;set;}
    public List<SelectOption> objects{get;set;}
    
    public String objDesc{get;set;}
    
    //Fiels
    public Map<String,Schema.SobjectField> f{get;set;}
    public List<String> fieldList{get;set;}
    public set<String> fSelected{get;set;}
    public set<String> fnotselected{get;set;}
    public List<SelectOption> fsoptions{get;set;}//selectedList
    public List<SelectOption> fnsoptions{get;set;}
    
    public String sfields{get;set;}
    public String rfields{get;set;}
    
    
    
    
    public Schema_Class(){
        m = Schema.getGlobalDescribe();
        objects = new List<SelectOption>();
        //fields:
        fieldList = new List<String>();
        
        fSelected = new set<String>();
        fnotselected = new set<String>();
        
        fsoptions = new List<SelectOption>();
        fnsoptions= new List<SelectOption>();
        
        objlist = new List<String>();
        objlist.addAll(m.keySet());
        objlist.sort();
        
        //for picklist
        SelectOption op = new SelectOption('None','--None--');
        objects.add(op);
        for(String obj : objlist){
            objects.add(new SelectOption(obj,obj));
        }
        
        
        
        
    }
    //Properties of Sobjects : Schema.SObjectDescribeResult
    public void objDetails(){
       // Schema.DescribeSObjectResult res = m.get(selectedObj).getDescribe();
        //objDesc =' '+ res;
        
        f = m.get(selectedObj).getDescribe().fields.getMap();
        System.debug(f);
        fieldList.addAll(f.keySet());
       	fieldList.sort();
        
        fnotselected.addAll(fieldList);
        show();
        
    }
    public void show(){
        fnsoptions.clear();
        for(String s :fnotselected){
            SelectOption op= new SelectOption(s,s);
            
			fnsoptions.add(op);            
        }
    }
    
}
    //Fields of the sobject
	
    
   /* Public string SelectedObject{get;set;}
 Public Map<String, Schema.SObjectType> AllObjectMap;
 Public Schema_Class(){
    AllObjectMap = New Map<String, Schema.SObjectType>();
    AllObjectMap = Schema.getGlobalDescribe();
    
}
    Public List<selectoption> getAllObjList(){
        List<selectoption> SobjectList = new List<selectoption>();
        for(string s: AllObjectMap.keyset()){
            SobjectList.add(new selectoption(s,s));
        }
      return SobjectList;   
     }*/
    /*Map<String, Schema.SobjectType> m{get;set;}
    public List<String> objlist{get;set;}
    public List<SelectOption> objects{get;set;}
    public String selectObj{get;set;}
    public String getDes{get;set;}
    
    //List of Fields on the object want you selected
   /* public Map<String, Schema.SobjectFields> fields{get;set;}
    public List<String> f{get;set;}*/