({
    doInit : function(component, event, helper) {

        let action = component.get("c.getObjectNames");
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log(result);
                let res = [];
                for(let k in result){
                    res.push({'label' : result[k] , 'value' : k });
                    console.log(res);
                }
                component.set("v.options", res);
            }
           
            console.log("Objects :"+ component.get("v.options"));
        });
        $A.enqueueAction(action);


    },
    handleChange : function(component, event, helper) {
         component.set("v.show", true);   
         let action = component.get("c.getFields");
         action.setParams({
             'objs' : component.get("v.selectedObj")
         })
         
        
         action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                let fieldResult = response.getReturnValue();
                console.log(fieldResult);
                let res = [];
                for(let k in fieldResult){
                    res.push({label : fieldResult[k] , value : k });
                    
                }
                component.set("v.picklistField", res);
            }
            console.log("fiels name :" , component.get(v.sfield));
         });
         $A.enqueueAction(action);


    },
    picklistHandleChange : function(component, event, helper) {
        let action = component.get("c.KanbanPicklist_Values");
        action.setParams({
            'obj' : component.get("v.selectedObj"),
            'picklistFieldName' : component.get("v.picklistFieldSelected")
        });
        
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                let picklistVal = response.getReturnValue();
               /* let res = [];
                for(let p in picklistVal){
                    res.push({label : picklistVal[p] , value : p });
                }*/
                component.set("v.picklistValues", picklistVal);
                console.log("picklist Values : " , component.get("v.picklistValues"));
            }
        });
        $A.enqueueAction(action);
        
    }
})