({
	getData : function(component){
    	var action = component.get('c.getCaseRecords');
    	action.setParams({
        	RecordId : component.get('v.recordId')
		
    	});
        
        action.setCallback(this, function(response) {
             var state = response.getState();
             if(state ==="SUCCESS"){
                 var result = response.getReturnValue();
                console.log(result);
            	component.set('v.data', response.getReturnValue());
             }
            else if(state ==="ERROR"){
				 var errors=response.getError();
            	 console.error(errors);                
            }
            
        });  
        $A.enqueueAction(action);
    }
        
    /*action.setCallback(this,$A.getCallback(function(response){
        var state response.getState();
        if(state ==="SUCCESS"){
            component.set('v.data', response.getReturnValue());
        }else if(state ==="ERROR"){
            var errors=response.getError();
            console.error(errors);
       }
    }));
    $A.enqueueAction(action);*/
})