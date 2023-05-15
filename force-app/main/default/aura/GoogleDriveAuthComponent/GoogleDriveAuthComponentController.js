({
    	doInit : function(component, event, helper) {
            //component.set("v.ShowComponent", true);
            component.set("v.spinner", true);
            var action = component.get("c.getUserInfo");
            action.setCallback(this, function(response){
                var state = response.getState();
                if(state == 'SUCCESS'){
                    let result = response.getReturnValue();
                    console.log('getUserInfo response : ', result);

                    if(result == 'Access Token Exist'){
                        let parent = 'root';
                        helper.getAllFilesAndFolder(component,event, parent);
                        //let errorcode = helper.getAllFilesAndFolder(component,event, parent);
                        //console.log('ERROR CODEEEEEEEEEEEEEEEEEEEEE :' , errorcode);
                    }
                    else{
                        
                        let authUrl = window.location.href;
                        let url = new URL(authUrl);
                        let code = url.searchParams.get("code");
                        console.log('Code is :' , code);
                        if(code == null || code == undefined){

                            window.open(response.getReturnValue(), '_self');
                        }
                        else{
                            console.log('getToken Method call');
                            helper.getToken(component,event,code);
                        }

                    }

                                
                }
                    
                      
                component.set("v.spinner", false);
            });
            $A.enqueueAction(action);
            
            let crumbList = [{id : "root" , name : "GoogleDrive"}];
            component.set("v.BreadCrumbs", crumbList);

        
    },
    createFolderModal : function(component, event, helper) {
        component.set("v.spinner", true);
        component.set("v.showModal", true);
        component.set("v.spinner", false);
        

    },
    createNewFolder : function(component,event,helper) {
        
        var crumbList = component.get("v.BreadCrumbs");
        var parentId = crumbList[crumbList.length-1].id;
        console.log('id', parentId);

        let action = component.get("c.createFolder");
        action.setParams({
            'folderName' : component.get("v.FolderName"),
            'parentId' : parentId
            //'parentId' : 'root'
           
        });
        console.log('FolderName : ', component.get('v.FolderName'));
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is :', state);
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result is :', result);
                let res = JSON.parse(result);
                console.log('JSON Object :' , res);
                console.log('New Folder id :', res.id);
                console.log('New folder Name :', res.name);

                let folderData1 = component.get("v.folderData");
                console.log('Folder Data :' , folderData1);

                //Add New folder in existing Folder
                folderData1.push({key : res.id , value : res.name});
                let parent = 'root';
                alert('Folder Created');
                helper.getAllFilesAndFolder(component,event,parentId);
               
            }

            
        });
        $A.enqueueAction(action);

    },
    closeModal : function(component, event, helper) {
        component.set("v.showModal", false);
         
    },
    
    openFolder : function(component, event, helper) {
        component.set("v.spinner", true);
        console.log('Hii from Open folder');
        let folderId = event.target.dataset.key;
        console.log('Folder Id ', folderId);
        let folderName = event.target.dataset.value;
        console.log('Folder Name ', folderName);
        //let Url ='https://www.googleapis.com/drive/v3/files?q=\''+folderId+'\'+in+parents';
        //console.log('URL :' , Url);
        let parent = folderId;
        helper.getAllFilesAndFolder(component,event, parent);

        let crumbList = component.get("v.BreadCrumbs");
        crumbList.push({id : folderId, name : folderName });
        component.set("v.BreadCrumbs", crumbList);
        console.log('BreadCrumbs :' , component.get('v.BreadCrumbs'));
  
    },
    bCrumbNavigation : function(component, event, helper) {
        component.set("v.spinner", true);

       
        let name = event.target.dataset.name;
        console.log('Name is  :', name);
        let folderId = event.target.dataset.id;
        console.log('Id is  :', folderId);
        
        let crumbList = component.get("v.BreadCrumbs");
        console.log('length :' , crumbList.length);
        crumbList.forEach(b => {
            if(b.name == name){
                let index = crumbList.findIndex(obj => obj.name == name);
                console.log('Index :' , index);
                crumbList.length = parseInt(index) + parseInt(1);
            }

        });
        component.set("v.BreadCrumbs",crumbList);
        
        helper.getAllFilesAndFolder(component,event,folderId);
        
    },
    // openFileLink : function(component, event, helper) {
    //     //alert("Hii");
    //     let fileId = event.target.dataset.key;
    //     console.log('File id ', fileId);

        
    // },
    delFolder : function(component, event, helper) {
        let folderId = event.currentTarget.dataset.key;
        let folderName = event.currentTarget.dataset.value;
        console.log('Folder Id is  : ' , folderId);
        console.log('Folder Name is  : ' , folderName);
        let action = component.get("c.deleteFolder");

        action.setParams({
            'folderId' : folderId
        });

        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is :', state);

            if(state == 'SUCCESS'){
                let statusCode = response.getReturnValue();
                console.log('Response is :', statusCode);
                if(statusCode == '204'){
                    let Data = component.get("v.folderData");
                    console.log('Folder Data :' , Data );
                    
                    var index = Data.findIndex(obj => obj.key == folderId);
                    console.log(index);
                    Data.splice(index, 1);
                    component.set("v.folderData", Data);
                    alert('Folder Deleted');
                }
                
                
            }
        });
        $A.enqueueAction(action);


    },

    delFile : function(component, event, helper) {
      
        let fileId = event.currentTarget.dataset.key;
        console.log('File Id  :' , fileId);
        let action = component.get("c.deleteFolder");

        action.setParams({
            'folderId' : fileId
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is :', state);

            if(state == 'SUCCESS'){
                let statusCode = response.getReturnValue();
                console.log('Response is :', statusCode);
                if(statusCode == '204'){
                    let Data = component.get("v.fileData");
                    console.log('File Data :' , Data );
                    
                    var index = Data.findIndex(obj => obj.key == fileId);
                    console.log(index);
                    Data.splice(index, 1);
                    component.set("v.fileData", Data);
                    alert('File Deleted');

                }
                
            }
        });
        $A.enqueueAction(action);

    },


    downloadFile : function(component, event, helper) {
       
        let fileId = event.currentTarget.dataset.key;
        console.log('File Id  :' , fileId);
        let name = event.currentTarget.dataset.value;
        console.log('Name  :' , name);

        let action = component.get("c.downloadFileData");
        action.setParams({
            'fileId' : fileId
        });

        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is ', state);
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result is  :', result);
                 if(result != null){
                    window.open(result,'_blank');
                    
                }
                else{
                    alert('can\'t Download This File');
                    
                }
               
            }

        });
        $A.enqueueAction(action);
    },
    
    uploadNewFile :function(component, event, helper) {
       
        component.set('v.show', true);
        
    },

    fileUpload : function(component, event, helper) {
     
        let getfile = component.find('fileSelector').get('v.files');
        console.log('File Data :' , getfile);
        
        var crumbList = component.get("v.BreadCrumbs");
        var parentId = crumbList[crumbList.length-1].id;
        console.log('id', parentId);
        //var parentId = 'root';

        let fileBoundary = 'FileBoundary';
        let delimeter = "\r\n--" + fileBoundary + "\r\n";
        let close_delim = "\r\n--" + fileBoundary + "--";
        console.log('hello from controller2');

        let reader = new FileReader();
        reader.readAsBinaryString(getfile[0]);
        console.log("HHHHHHHHHHHHHHHHHH");
        reader.onload = function(e){
            let contentType = getfile[0].type || 'application/octet-stream';
            let fileName = getfile[0].name;
            let baseData = btoa(reader.result);

            var fileBody = delimeter +
                'Content-Type: application/json\r\n\r\n' + 
                '{ "title" : "' + fileName + '",' + ' "mimeType" : "' + contentType + '",' + '"parents":[{"id":"'+ parentId +'"}]}'+
                 delimeter +
                'Content-Type: ' + contentType + '\r\n' +
                'Content-Transfer-Encoding: base64\r\n' +
                '\r\n' + baseData + close_delim;

                console.log('File Body !!!!!!!!!!!!!!!!!!!!!!!1' , fileBody);
 				console.log('hello from controller3');
                helper.uploadFileToDrive(component, event, fileBody, fileBoundary);
        }
        
    },
    closeUploadModal : function(component, event, helper) {
        component.set("v.show", false);
    },

    
    
  
})