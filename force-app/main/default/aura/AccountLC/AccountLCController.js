({
    doInit : function (component,event, helper) {
         
          
        var action = component.get('c.ObjectNames');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") {
                var result = response.getReturnValue();
                console.log(result);
                
                var arrayMapKeys = [];
                for(var key in result) {
                    arrayMapKeys.push({label: key, value: result[key]});
                    console.log(key);
                    console.log( result[key]);
                }
                component.set("v.availableObject", arrayMapKeys);
                console.log(component.get("v.availableObject"));
                
            }
        });
        $A.enqueueAction(action);
    }
    
	/*doInit : function(component, event, helper) {
        console.log("method call");
        //call method of apex controller : getAccounts();
        var action = component.get("c.getAccounts");	//first call the apex method
        
         action.setCallback(this,function(response){
            
                component.set("v.acctList", response.getReturnValue());
            
        });
        $A.enqueueAction(action);
        
		
	}*/
})