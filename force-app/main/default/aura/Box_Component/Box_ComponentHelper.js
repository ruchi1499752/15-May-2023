({
    getToken : function(component,event,code) {
        console.log('Hii from getToken Method');
        console.log('Code is :' , code);

        let action = component.get("c.requestAccessToken");
        action.setParams({
            'code' : code
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is :' , state);
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result is  :' , result);
                let parent = "0";
                this.getData(component,event,parent);
                //let parent = 0;
                //this.getData(component,event);
            }

        });
        $A.enqueueAction(action);

    },
    getData : function(component,event,parent) {
        console.log('Parent id is :' , parent);

        let action = component.get("c.getAllfilesAndFolders");
        action.setParams({
            'folderId' : parent
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is :' , state);

            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result is ', result);
                let obj = JSON.parse(result);
                console.log('JSON Object :' , obj);

                let boxData = obj.entries;
                console.log('Files and foldes : ', boxData);

                let files = [];
                let folders = [];

                for(let i = 0; i<boxData.length; i++){
                    if(boxData[i].type == 'folder'){
                        folders.push({key : boxData[i].id , value : boxData[i].name});
                    }else{
                        files.push({key : boxData[i].id , value : boxData[i].name});
                    }
                }
                component.set("v.folderData", folders);
                console.log('Folder data :' , component.get("v.folderData"));
                component.set("v.fileData", files);
                console.log('File data :' , component.get("v.fileData"));

            }
        });
        $A.enqueueAction(action);


    },
    uploadFileToDrive : function (component, event,base,filename, id){
        console.log('hello from helper');
        let action = component.get("c.uploadFile");
        action.setParams({
            base64 : base,
            fileName : filename,
            folderId : id
           
        });

        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is  :' , state);

            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result is :' , result);
            }
        });
        $A.enqueueAction(action);
        /*action.setParams({
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
        $A.enqueueAction(action);*/
    }
})