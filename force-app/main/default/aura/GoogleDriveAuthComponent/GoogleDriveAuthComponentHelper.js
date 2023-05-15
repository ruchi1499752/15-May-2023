({
    getToken : function(component,event,code) {
        console.log('call getToken ');
        console.log('Code for getToken : ', code);
        var action  = component.get("c.getAccessToken");
         
        action.setParams({
            'code' : code
            
        });
        
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is : ', state);
            console.log(' Result : '+response.getReturnValue());
            if(state == 'SUCCESS'){
                let accessToken = response.getReturnValue();
                console.log('AccessToken : ' , accessToken);
                component.set("v.accessToken", accessToken);
                let parent = 'root';
                this.getAllFilesAndFolder(component,event,parent);


                
            }
        
        });
        
         $A.enqueueAction(action);  
    },

    getAllFilesAndFolder : function(component,event, parent) {
        console.log('getFileMethod call!!!!!');
        console.log('Parent id :', parent);

       // console.log('Access Token is : ', accessToken);
        var action  = component.get("c.getFiles");
        action.setParams({
            'parentId' : parent
        });

        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is : ', state);

            if(state == 'SUCCESS'){
                let files = response.getReturnValue();
                let res = JSON.parse(files);    //Parse a string (written in JSON format) and return a JavaScript object:
                console.log('Result is : ', res);

                
                // let error = res.error;
                // console.log('Error Code :' , error.code);

                // if(error.code == '401'){
                //     console.log('error Code');
                //     let invalidCode = error.code;
                //     console.log('Error code is :' , invalidCode);
                //     //return invalidCode;
                // }
                // else{
                console.log("Else Part Run");
                let fileAndFolder = res.files; 
                console.log('fileAndFolder' , fileAndFolder);

                let file = [];
                let folder = [];

                for(var i=0; i<fileAndFolder.length; i++){
                    if(fileAndFolder[i].mimeType == 'application/vnd.google-apps.folder'){
                        folder.push({key : fileAndFolder[i].id , value : fileAndFolder[i].name});
                    }else{
                        file.push({key : fileAndFolder[i].id , value : fileAndFolder[i].name});
                    }
                }
                
                //console.log('Files :', files);
                //component.set("v.data", JSON.parse(files));
                component.set("v.fileData", file);
                console.log('Files : ', files);
                component.set("v.folderData", folder);
                console.log('Folders : ', folder);


            

            }
        
            component.set("v.spinner", false);
        });
        $A.enqueueAction(action);    

    },
    uploadFileToDrive : function (component, event,filebody, fileBoundary){
        console.log('hello from helper');
        let action = component.get("c.uploadFile");
        action.setParams({
            fileBody : filebody, boundary : fileBoundary
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result is :' , result);
                let obj = JSON.parse(result);
                console.log('Object :' , obj);
                console.log('File id is :', obj.id);
                console.log('File name is :' , obj.title);
                let dataList = component.get("v.fileData");
                dataList.push({key : obj.id, value : obj.title });
                console.log('DataList is :',dataList);
                //dataList.push(result);
                component.set("v.fileData",dataList);
                console.log('Uploaded Data :' , component.get('v.fileData'));

                alert('upload SuccessFully');
                
                

            }
        });
        $A.enqueueAction(action);
    }

   
    
})