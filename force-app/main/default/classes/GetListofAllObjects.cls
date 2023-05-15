public class GetListofAllObjects {
    Map<String, Schema.SObjectType> m = Schema.getGlobalDescribe();
    //System.debug(m);
    
     /*Public string SelectObj{get;set;}
     Public Map<String, Schema.SObjectType> AllObjMap;
     Public GetAllObjectsListControll(){
        AllObjMap= New Map<String, Schema.SObjectType>();
        AllObjMap= Schema.getGlobalDescribe();
    }
    Public List<selectoption> getAllObjectList(){
        List<selectoption> AllobjectList = new List<selectoption>();
        for(string r:AllObjMap.keyset()){
            AllobjectList.add(new selectoption(r,r));
        }
      return AllobjectList;   
     }*/
}