public class ObjectName {
     Public string SelectedObj{get;set;}
    public String SelectField{get;set;}
     Public Map<String, Schema.SObjectType> AllObjectMap;
    Public Map<String, Schema.SObjectField> AllfieldMap;
    
     Public ObjectName(){
        AllObjectMap = New Map<String, Schema.SObjectType>();
        AllObjectMap = Schema.getGlobalDescribe();
        AllfieldMap = New Map<String, Schema.SObjectField>();
        
         
	}
	Public List<selectoption> getAllObjList(){
        List<selectoption> SobjectList = new List<selectoption>();
       
            for(string s:AllObjectMap.keyset()){
            SobjectList.add(new selectoption(s,s));
        	}
        
        
        
        
      return SobjectList;   
 	}
    
   /* public List<selectoption> getAllFieldList(){
       // Map<String, Schema.SObjectType> AllObjectMap = Schema.getGlobalDescribe();
        AllfieldMap = AllObjectMap.get(SelectedObj).getDescribe().fields.getMap();
        
        List<Selectoption> flist = new List<selectoption>();
        for(String r : AllfieldMap.keySet()){
            flist.add(new selectoption(r,r));
            System.debug(r);
        }
        return flist;
    }*/
}