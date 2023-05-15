({
	doInit : function(component,event,helper){
    component.set('v.validate',function(){
        var userInput=component.get('v.selectedRowsList');
        if(userInput && userInput.length>0){
            // If the component is valid ...
            return {isValid:true};
   
        }else{
       
            // If the component is invalid ...
                  return {isValid:false, errorMessage:'A value is required.'};
     }
    });
                  
 
        component.set('v.columns',[
           
            {label:'Subject', fieldName:'Subject',type:'text'},
            {label:'Web Email', fieldName:'SuppliedEmail',type:'email'}
        ]);
        helper.getData(component);
    },
    
    /*getSelectedRecord : function(component, event, helper){
        var selectedRows = event.getParam('SelectedRows');
        
    }*/
    
   
})