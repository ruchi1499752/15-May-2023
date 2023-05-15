({
    doInit : function(component, event, helper) {
        var action = component.get("c.getRecords");
       action.setParams(
            {pageNumber : component.get("v.pageNumber"),
          
             pageSize : component.get("v.pageSize")  
            }
        );
       
        action.setCallback(this, function(response){
            console.log(response.getReturnValue());
            
            component.set("v.AccList", response.getReturnValue());
            console.log(component.set("v.AccList", response.getReturnValue()));
           
        });
        $A.enqueueAction(action);

        


    }
})