({
    doInit : function(component, event, helper) {
        console.log('Call DoInit');
        let action = component.get("c.getUserInfo");
        
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is :', state);
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log(' response : ', result);
                if(result == 'Token Exist'){
                    let parent = '0';
                    helper.getData(component,event,parent);
                }else{
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
        });
        $A.enqueueAction(action);
        let crumbList = [{id : "0" , name : "Box"}];
        component.set("v.BreadCrumbs", crumbList);
            

    },
    createFolderModal : function(component, event, helper) {
        component.set("v.showModal", true);
    },
    createNewFolder : function(component,event,helper) {
		var crumbList = component.get("v.BreadCrumbs");
        var parentId = crumbList[crumbList.length-1].id;
        console.log('id', parentId);
        
        let action = component.get("c.createFolder");
        action.setParams({
            'folderName' : component.get("v.FolderName"),
            //'parentId' : "0"
            'parentId' : parentId
           
        });
        console.log('FolderName : ', component.get('v.FolderName'));
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('Satae is :' , state);
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Response is  :', result);

                let res = JSON.parse(result);
                console.log('JSON Object :', res);
                console.log('New Folder Id :' , res.id);
                console.log('New Folde Name :', res.name);

                let folderData1 = component.get("v.folderData");
                console.log('Folder Data :' , folderData);

                //Add New folder in existing Folder
                folderData1.push({key : res.id , value : res.name});
                let parent = '0';
                helper.getData(component,event,parent);




            }
        });
        $A.enqueueAction(action);
    },
    closeModal : function(component, event, helper) {
        component.set("v.showModal", false);
    },

    delFolder : function(component, event, helper) {
        
        let folderId = event.target.dataset.key;
        console.log('Folder Id is :' , folderId);

        let folderName = event.target.dataset.value;
        console.log('Folder Name is :' , folderName);

        let action = component.get("c.deleteFolder");
        action.setParams({
            'folderId' : folderId
        });    

        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is :' , state);

            if(state == 'SUCCESS'){
                let statusCode = response.getReturnValue();
                console.log('Delete Folder Result :', statusCode );

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
     
        let fileId = event.target.dataset.key;
        console.log('File Id is :', fileId);
        let fileName = event.target.dataset.value;
        console.log('File Name :' , fileName);

        let action = component.get("c.deleteFile");
        action.setParams({
            'fileId' : fileId
        });
        action.setCallback(this,function(response){
            let state = response.getState();
            console.log('State is :', state);
            if(state == 'SUCCESS'){
                let statusCode = response.getReturnValue();
                console.log('Delete File statusCode :' , statusCode);
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
       
        let fileId = event.target.dataset.key;
        console.log('File Id  :' , fileId);
        let fileName = event.target.dataset.value;
        console.log('File Name :' , fileName);

        let action = component.get("c.downloadBoxFile");
        action.setParams({
            'fileId' : fileId
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log('State is ', state);
            if(state == 'SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result is  :', result);

                if(result == null){
                    alert('can\'t Download This File');
                }
                else{
                    window.open(result,'_self');
                }
               
            }

        });
        $A.enqueueAction(action);

    },


    openFolder : function(component, event, helper) {
        //component.set("v.spinner", true);
        console.log('Hii from Open folder');
        let folderId = event.target.dataset.key;
        console.log('Folder Id ', folderId);
        let folderName = event.target.dataset.value;
        console.log('Folder Name ', folderName);
        //let Url ='https://www.googleapis.com/drive/v3/files?q=\''+folderId+'\'+in+parents';
        //console.log('URL :' , Url);
        let parent = folderId;
        helper.getData(component,event, parent);

        let crumbList = component.get("v.BreadCrumbs");
        crumbList.push({id : folderId, name : folderName });
        component.set("v.BreadCrumbs", crumbList);


        console.log('BreadCrumbs :' , component.get('v.BreadCrumbs'));

        //console.log('Folder Data :' ,getfolderData );

        
        
    },
    bCrumbNavigation : function(component, event, helper) {
        //component.set("v.spinner", true);
        
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
        
        helper.getData(component,event,folderId);
        
    },


    uploadNewFile :function(component, event, helper) {
        alert('Hii from UploadNewFile');
        component.set('v.show', true);
        console.log("hieeeee!!");

        

        // let action = component.get("c.UploadFile");
        // action.setParams({
        //     'fileName' : ,
        //     'folderId' : '0';
        // });
        
    },
    closeUploadModal : function(component, event, helper) {
        component.set("v.show", false);
    },
    fileUpload : function(component, event, helper) {
        console.log("hieeeee!!");
        let getfile = component.find('fileSelector').get('v.files');
        console.log('File Data :' , getfile);

        var crumbList = component.get("v.BreadCrumbs");
        var parentId = crumbList[crumbList.length-1].id;
        console.log('ParentId', parentId);

      
       
        var reader = new FileReader();
        reader.readAsDataURL(getfile[0]);
        reader.onload = function(e){
             let base64c = reader.result;
        
        //let base = base64c;
        let filename = getfile[0].name;
        console.log('base64 :' , base64c);
        console.log('File name :', filename);
        console.log('Parent Id :' , parentId);

        helper.uploadFileToDrive(component,event,base64c, filename, parentId);

        }

        
        
       
    }

    
})