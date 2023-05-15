({
    fetchRecords : function(component,event,pageNumber,recordSize) {
        let query = 'select ' + flds + ' from ' + obj + ' ORDER BY ID LIMIT ' + recordSize;
        let action = component.get("c.getRecords");
        
        action.setParams(
            {'qry' : query,
            //pageNum : pageNumber,
            //pageSize :  recordSize 
            }
        );
        action.setCallback(this, function(response){
            console.log(response.getReturnValue());
            
            component.set("v.record", response.getReturnValue());
            console.log(component.set("v.record", response.getReturnValue()));
            //component.set("v.totalSize", component.get("v.record").length);
        });
        $A.enqueueAction(action);
        
        let displayData = [];
        flds.forEach(fldsValue => {  
            displayData.push({label : fldsValue, fieldName : fldsValue});
        });    
        component.set("v.field", displayData);

        

    }
})