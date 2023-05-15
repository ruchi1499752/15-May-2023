({
	removeCSS : function(component, event, helper) {
        //component.set('v.showModal', false);
		//alert('Modal Call');
		//$A.get("e.force:closeQuickAction").fire();
		var cmpTarget = cmp.find('MainDiv');
        $A.util.removeClass(cmpTarget, 'slds-modal__container');
	}
})