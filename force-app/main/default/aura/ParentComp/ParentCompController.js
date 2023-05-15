({
    doInit : function(component, event, helper) {
        let json = {
            "objectName":"Account",
            "fields":["Id","Name","AccountNumber","Phone","Rating","Type","Industry","Description"]
        };
        component.set('v.data',json);
        console.log(component.get('v.data.objectName'));
        console.log(component.get('v.data.fields'));
        component.set('v.show',true);
    }
})

/*
 "objectName":"Account",
 "fields":["Id","Name","AccountNumber","Phone","Rating","Type","Industry","Description"]
*/

/*
"objectName":"Case",
"fields":["Id","AccountId","CaseNumber","Reason","Description","Comments","IsClosed"]
*/
/*
"objectName":"Contact",
"fields":["Id","AccountId","Name","Phone","Description","CreatedDate","Birthdate"]
*/