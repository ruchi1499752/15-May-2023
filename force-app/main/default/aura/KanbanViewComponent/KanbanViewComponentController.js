({
	doInit : function(component, event, helper){
        component.set("v.spinner", true);
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
            component.set("v.spinner", false);
        });	
        $A.enqueueAction(action);
    },
    
   
    handleChange : function(component, event, helper){
        component.set("v.spinner", true);
		component.set("v.showPickListField", true);
        component.set("v.showRecords", false);
        
        
        let action = component.get("c.getFields");
        action.setParams({
            "objs" : component.get("v.selectedObj")
        });
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                let fieldResult = response.getReturnValue();
                
                let res = [];
                for(let k in fieldResult){
                    res.push({label : fieldResult[k] , value : k });
                }
                
                if(res.length>0){
                    
                    component.set("v.showAvailablePicklist", true); 
                }    
                else{
                    component.set("v.showAvailablePicklist", false);
                     
                    //alert('No Picklist Field Available in this Object..');
                }
                component.set("v.picklistField", res);
            }
            component.set("v.spinner", false);
        });
        $A.enqueueAction(action);
	},
    
    picklistFieldChange : function(component, event, helper) {
        //component.set("v.showPickListField", false);
        
        component.set("v.spinner", true);
        
      
		let action = component.get("c.KanbanPicklist_Values");
        action.setParams({
            "obj" : component.get("v.selectedObj"),
            "picklistFieldName" : component.get("v.picklistFieldSelected")
        });
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                let picklistVal = response.getReturnValue();
                component.set("v.showRecords", true);
                let res = [];
                for(let p in picklistVal){
                    res.push({ key : p , value : picklistVal[p]});
                }
				/*let temp = Object.values(picklistVal);
                temp.forEach(ele =>{
                    let val = Object.values(ele);
                    console.log("Values :" ,val);
                });*/
				component.set("v.picklistRecords", res );
              	console.log('picklist Values related Records :  ' + JSON.stringify(component.get("v.picklistRecords")));
            }
            component.set("v.spinner", false);
           
            
        });
        $A.enqueueAction(action);
    },
    
    /*** Drag and Drop Functionality ***/
    
    
    dragElement : function(component, event, helper) {
       	event.dataTransfer.setData("text", event.target.id);	//Event : dragElement , Hold data to be drag, setData(format, data), targer : ul
    	let prevValue= event.target.parentElement.getAttribute('id');
        //console.log("Parent  : " , prevValue);
        event.dataTransfer.setData("prevValue", prevValue);
      
    },
    
    allowdrop : function(component, event, helper) {
        event.preventDefault(); //Not Allow curser(mouseEnter, mouseMove Event)
    }, 
    
    dropElement : function(component, event, helper) {
       	event.preventDefault();

        var data = event.dataTransfer.getData("text");
        var tar = event.target;
        while(tar.tagName != 'div' && tar.tagName != 'DIV') {
            tar = tar.parentElement;
            console.log('target', tar);
        }
       	tar.appendChild(document.getElementById(data));
        document.getElementById(data).style.backgroundColor = "#ffb75d";

        
        let prevCol = event.dataTransfer.getData("prevValue");
        console.log('Previous Column  : ', prevCol);
        let newColumn = tar.getAttribute('id');
		console.log('New Column : ', newColumn);        
        
       /*console.log('Record Id : ' , data);
       console.log('Picklist Field :', component.get("v.picklistFieldSelected"));
       console.log('target attribute (PicklistValue) :', tar.getAttribute('id'));*/
       helper.updateRecord(component, data, component.get("v.picklistFieldSelected"), tar.getAttribute('id'));
       
       
       let oldSize = document.getElementById(prevCol).innerText;
       //let o -= oldSize;
       //console.log('Old Size Text Content : ', document.getElementById(prevCol).innerHTML);
       //console.log('Old Size Text Content 2 : ', document.getElementById(prevCol).textContent);

       document.getElementById(prevCol).innerHTML = --oldSize;
      
     
       console.log('OldSize', oldSize);

       let newSize = document.getElementById(newColumn).innerText;
       document.getElementById(newColumn).innerHTML = ++newSize;
       console.log('NewSize', newSize);

       //document.getElementById(prevColId).textContent = --oldSize;
        
        	
        
    },
    
    updateRecord : function(component, recId, pField, pVal) {
       helper.updateRecord(component, recId, pField, pVal);
                           
	},

   /* kanbanRecords : function(component, event, helper) {
        let action = component.get("c.getRecords");
        action.setParams({
            "obj" : component.get("v.selectedObj"),
            "picklistFieldName" : component.get("v.picklistFieldSelected")
        });
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                let picklistVal = response.getReturnValue();
               
                component.set("v.kanbanData", picklistVal);
                console.log("Records : " , component.get("v.kanbanData"));
            }
        });
        $A.enqueueAction(action);
        
    }*/
})