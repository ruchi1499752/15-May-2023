public class Schema_Sobjects {
    public Map<String, SobjectType> m{get;set;}
    public List<SelectOption> objects{get;set;}
    public List<String> objList{get;set;}
    public String selectedObj{get;set;}
    public String objDescription{get;set;}
    
    //Fields :
    public Map<String,Schema.SobjectField> mfields{get;set;}
    public List<String> fields{get;set;}//List of fields
    public List<SelectOption> fsoptions{get;set;}// for selected list
    public List<SelectOption> fnsoptions{get;set;}
    public set<String> fSelected{set;get;}  
    public set<String> fnotselected{set;get;}  
    public List<String> sFields{get;set;}
    public List<String> rFields{get;set;}
    
    
    
    public Schema_Sobjects(){
        m = Schema.getGlobalDescribe(); 
        fields=  new List<String>();
        fSelected = new set<String>();
        fnotselected = new set<String>();
		fsoptions = new List<SelectOption>(); 
        fnsoptions = new List<SelectOption>();
        sFields = new List<String>();
         rFields = new List<String>();
        
        
        objects = new List<SelectOption>();
        
        objList = new List<String>();
        objList.addAll(m.keySet());
        //System.debug(objList);
        objList.sort();
        SelectOption op = new SelectOption('None','---None---');
        objects.add(op);
        for(String s : objList){
            objects.add(new SelectOption(s,s));
            
     	}
    }
    public void details(){
        Schema.DescribeSObjectResult res = m.get(selectedObj).getDescribe();
        objDescription = ' '+res;
        mfields = m.get(selectedObj).getDescribe().fields.getMap();
        fields.addAll(mfields.keySet());
        System.debug(fields);
        fields.sort();
        
       /* for(String r :fields){
            fnsoptions.add(new SelectOption(r,r));
            System.debug(r);
        }*/
        
       //fnotselected.addAll(fields);
       show();
        
    }
    public void show(){
        fnsoptions.clear();
        fsoptions.clear();
        
        for(String s : fnotselected){
            fnsoptions.add(new SelectOption(s,s));
            
        }
        for(String s1 : fSelected){
            fsoptions.add(new SelectOption(s1,s1));
        }
        
        
    }
   /*public void addFields(){
        fnotselected.removeAll(sFields);
        fsoptions.addAll(sFields);
        show();
        
    }
    public void removeFields(){
        fnotselected.addAll(rFields);
        fSelected.removeAll(rFields);
        show();
    }*/
}