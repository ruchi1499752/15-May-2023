({
	 goToRec : function(component, event, helper) {
          var navLink = component.find("navLink");
        var pageRef = {
            type: 'standard__recordPage',
            attributes: {
                actionName: 'view',
                objectApiName: 'Contact',
                recordId : '0035j00000nJxgSAAS' // change record id. 
            },
        };
        navLink.navigate(pageRef, true);
     },
    
    showToast : function(component, event, helper) {
          var navLink = component.find("navLink");
        var pageRef = {
            type: 'standard__recordPage',
            attributes: {
                actionName: 'view',
                objectApiName: 'Contact',
                recordId : '0035j00000nJxgSAAS' // change record id. 
            },
        };
         
    	 var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Successfully Saved!!!',
            message: 'Record has been Saved Successfully',
            type: 'Success',
            mode: 'dismissible',
           
            messageTemplate: 'Record has been Saved Successfully {1}',
            messageTemplateData: ['Salesforce', {
                //url: 'http://www.webkul.com/' ,
                //url: navLink.navigate(pageRef, true),
                label: 'OK',
                type: 'error',
               
            }],
            duration:' 5000',
           
           
           
        });
        toastEvent.fire();
	},
     showToast : function(component, event, helper) {
                
        var params = event.getParam( 'arguments' );  
        try {
          component.find('notifLib').showToast({
                "variant": params.messageType,
                "message": params.message,
                "mode": "dismissable"
            });
        }
        catch(err) {
            component.set("v.message", params.message);
            component.set("v.messageType", params.messageType);
            
            $A.util.removeClass( component.find( 'toastModel' ), 'slds-hide' );
            $A.util.addClass( component.find( 'toastModel' ), 'slds-show' );
            
            var closeTime =  component.get("v.autoCloseTime");
            var autoClose =  component.get("v.autoClose");
            var autoCloseErrorWarning =  component.get("v.autoCloseErrorWarning");
            
            if(autoClose)
                if( (autoCloseErrorWarning && params.messageType != 'success') || params.messageType == 'success') {
                setTimeout(function(){ 
                    $A.util.addClass( component.find( 'toastModel' ), 'slds-hide' ); 
                    component.set("v.message", "");
                    component.set("v.messageType", "");
                }, closeTime);
            }
        }
       
	},
    
	closeModel : function(component, event, helper) {
		$A.util.addClass( component.find( 'toastModel' ), 'slds-hide' );
        component.set("v.messageType", "");
        component.set("v.messageType", "");
	}
})