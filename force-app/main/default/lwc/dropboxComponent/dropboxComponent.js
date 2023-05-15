import { LightningElement,
         track
}from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getUserInfo from '@salesforce/apex/DropboxController.getUserInfo';
import getAccessToken from '@salesforce/apex/DropboxController.getAccessToken';
import getData from '@salesforce/apex/DropboxController.getData';
import createFolder from '@salesforce/apex/DropboxController.createFolder';
import deleteFolder from '@salesforce/apex/DropboxController.deleteFolder';
import downloadDropboxFile from '@salesforce/apex/DropboxController.downloadDropboxFile';
import UploadFile from '@salesforce/apex/DropboxController.UploadFile';
import dropbox_Img from '@salesforce/resourceUrl/DropBox_Logo';

export default class DropboxComponent extends LightningElement {
    DropBox_Logo = dropbox_Img;
    variant = 'Success';
    @track url;
    @track dataError;
    @track res;
    @track error;
    @track token;
    @track boxData = [];
    @track file = [];
    @track folder = [];
    @track fileAndFolders = [];
    @track obj;
    @track isShowModal = false;
    @track inputVal;
    @track folderResult;
    @track newFolder = [];
    @track deleteResult;
    @track myBreadcrumbs = [];
    @track getFolderId;
    @track ShowUploadFileModal;
   
    connectedCallback(){
        getUserInfo()
        .then(result =>{
            this.res = result;
            console.log('Value return from apex :' , this.res);
            if(this.res == 'Token exist'){
                let id = '';    //Root folder, use an empty string as the path.
                getData({parentId : id})
                .then(result =>{
                    this.boxData = result;
                    console.log('Box Data :' , result);
                    console.log('Result is :' , result[0].id);
                    console.log('Length :', result.length);
                    let tempFileList = [];
                    let tempFolderList = [];
                    for(var i=0; i<result.length; i++){
                        if(result[i].tag == 'folder'){
                            tempFolderList.push(result[i]);
                        }
                        else{
                            tempFileList.push(result[i]);
                        }
                    }
                    this.file = tempFileList;
                    this.folder = tempFolderList;
                    let crumb = [];
                    crumb.push({ id : '0', name : 'home'});
                    console.log(crumb);
                    this.myBreadcrumbs = crumb;
                    console.log(this.myBreadcrumbs);
                })
                .catch(error =>{
                    this.error = error;
                    console.log('Dropbox Data Error is ' + this.error);
                });
                
            }else{
                let authUrl = window.location.href;
                console.log('AuthUrl is :' + authUrl);
                let url = new URL(authUrl);
                let code = url.searchParams.get("code");
                console.log('Code is :' , code);
                if(code == null || code == undefined){

                    window.open(this.res, '_self');
                }
                else{
                    console.log('getToken Method call');
                    console.log('AuthCode is : ', code);
                    getAccessToken({authCode : code})
                    .then(result =>{
                        this.token = result;
                        console.log('Token response :' , this.token);
                        let id = '';
                        getData({parentId : id})
                        .then(result =>{
                            this.boxData = result;
                            console.log('Box Data :' , result);
                            console.log('Result is :' , result[0].id);
                            console.log('Length :', result.length);
                            let tempFileList = [];
                            let tempFolderList = [];
                            for(var i=0; i<result.length; i++){
                                if(result[i].tag == 'folder'){
                                    tempFolderList.push(result[i]);
                                }
                                else{
                                    tempFileList.push(result[i]);
                                }
                            }
                            this.file = tempFileList;
                            this.folder = tempFolderList;
                            let crumb = [];
                    
                            crumb.push({ id : '0', name : 'home' });

                            console.log(crumb);
                            this.myBreadcrumbs = crumb;
                            console.log(this.myBreadcrumbs);
                        })
                        .catch(error =>{
                            this.error = error;
                            console.log('Dropbox Data Error is ' + this.error);
                        });
                    })
                    .catch(error =>{
                        console.log('Token Error');
                    });
                }
            }
        })
        .catch(error =>{
          console.log('In connected call back error....');
          this.error = error;
          console.log('Error is ' + this.error);
        });
    }

    createFolderModal(){
        
        this.isShowModal = true;
        
    }
    hideModalBox(){
        this.isShowModal = false;
        this.ShowUploadFileModal = false;
    }
    changeInputValue(event){
        this.inputVal = event.target.value;
     
        console.log('Input Text Value  :' , this.inputVal);

    }   
    
    uploadModal(){
        
        this.ShowUploadFileModal = true;
    }
    handleFileUploaded(event){
       
        let getFile = event.target.files[0];
        console.log('Getting File Details:' , getFile);
        console.log('=====================================');
        let fName = getFile.name;
        console.log('File NAme :' , fName);

        let crumbId = this.myBreadcrumbs[this.myBreadcrumbs.length - 1].id;
        console.log('Breadcrumb id :' + crumbId);

        let folderPath = this.getFolderId;
        console.log('Folder Path :', folderPath);

        let reader = new FileReader();
        reader.onload = function(e){
            let base64 = reader.result.split(',')[1];
            console.log('Base 64 :' , reader.result);
            let filename = fName;

            if(crumbId !=0){
                UploadFile({path : folderPath  , fileName : fName , fileBody : base64})
                .then(result =>{
                    console.log('FileUpload Response :', result);
                    getData({parentId : folderPath})
                    .then(res =>{
                        console.log('result is', res);
                        let tempFileList = [];
                        let tempFolderList = [];
                        for(var i=0; i<res.length; i++){
                            if(res[i].tag == 'folder'){
                                tempFolderList.push(res[i]);
                            }
                            else{
                                tempFileList.push(res[i]);
                            }
                        }
                        this.file = tempFileList;
                        this.folder = tempFolderList;
                        //this.file = result;
                    })
                    .catch(error =>{
                        this.error = error;
                        console.log('Error is ' + this.error);
                    });
                   
                    

                })
                .catch(error =>{
                    console.log('Error is :', error);
                });

            }else{
                UploadFile({path : '', fileName : fName , fileBody : base64})
                .then(result =>{
                    console.log('FileUpload Response :', result);
                    getData({parentId : ''})
                    .then(res =>{
                        console.log('result is', res);
                        let tempFileList = [];
                        let tempFolderList = [];
                        for(var i=0; i<res.length; i++){
                            if(res[i].tag == 'folder'){
                                tempFolderList.push(res[i]);
                            }
                            else{
                                tempFileList.push(res[i]);
                            }
                        }
                        this.file = tempFileList;
                        this.folder = tempFolderList;
                        this.file = result;

                    })
                    .catch(error =>{
                        this.error = error;
                        console.log('Error is ' + this.error);
                    });    
                    

                })
                .catch(error =>{
                    console.log('Error is :', error);
                });
            }
            
        }
        reader.readAsDataURL(getFile);
        this.ShowUploadFileModal = false;
        event = new ShowToastEvent({
            title: 'File upload SuccessFully',
            message:
                '',
            variant: this.variant,    
                 
        });
        this.dispatchEvent(event);
     
    }
//====================================== Breadcrumbs Navigation =========================================// 
    handleNavigateTo(event){
        let crumbId = event.currentTarget.dataset.id;
        console.log('crumbId :', crumbId);
        let crumbName = event.currentTarget.dataset.name;
        console.log('crumbName :', crumbName);

        let folderPath = this.getFolderId;
        console.log('Folder Path :', folderPath);

        console.log('crumbList Size :' , this.myBreadcrumbs.length);

        let crumb = [];
        crumb = this.myBreadcrumbs;
        crumb.forEach(b => {
            if(b.id == crumbId){
                console.log('B is :', b);
                let index = crumb.findIndex(obj => obj.id == crumbId);
                console.log('Index :' , index);
                crumb.length = parseInt(index) + parseInt(1);
            }

        });
        this.myBreadcrumbs = crumb;
        console.log(this.myBreadcrumbs);

        if(crumbId != 0){
            getData({parentId : crumbId})
            .then(res =>{
                console.log('result is', res);
                let tempFileList = [];
                let tempFolderList = [];
                for(var i=0; i<res.length; i++){
                    if(res[i].tag == 'folder'){
                        tempFolderList.push(res[i]);
                    }
                    else{
                        tempFileList.push(res[i]);
                    }
                }
                this.file = tempFileList;
                this.folder = tempFolderList;
            })
            .catch(error =>{
                this.error = error;
                console.log('Error is ' + this.error);
            });
        }else{
            getData({parentId : ''})
            .then(res =>{
                console.log('result is', res);
                let tempFileList = [];
                let tempFolderList = [];
                for(var i=0; i<res.length; i++){
                    if(res[i].tag == 'folder'){
                        tempFolderList.push(res[i]);
                    }
                    else{
                        tempFileList.push(res[i]);
                    }
                }
                this.file = tempFileList;
                this.folder = tempFolderList;
            })
            .catch(error =>{
                this.error = error;
                console.log('Error is ' + this.error);
            });
        }
        

    }
//====================================== Open Folder =========================================// 
    createNewFolder(event){
        console.log('Folder Name :' , this.inputVal);
        let crumbId = this.myBreadcrumbs[this.myBreadcrumbs.length - 1].id;
        console.log('Breadcrumb id :' + crumbId);

        console.log('Folder ID !!!!!!', this.getFolderId);
        if(crumbId != 0){
            createFolder({folderName : this.inputVal , path : this.getFolderId})
            .then(result =>{
                this.folderResult = result;
                console.log('Folder Response :' , result);

                console.log(JSON.parse(result).id);
                console.log(JSON.parse(result).name);

                let res = JSON.parse(JSON.stringify(this.folder));
                console.log('Folder Data:', res);

                
                getData({parentId : this.getFolderId})
                .then(res =>{
                    console.log('result is', res);
                    let tempFileList = [];
                    let tempFolderList = [];
                    for(var i=0; i<res.length; i++){
                        if(res[i].tag == 'folder'){
                            tempFolderList.push(res[i]);
                        }
                        else{
                            tempFileList.push(res[i]);
                        }
                    }
                    this.file = tempFileList;
                    this.folder = tempFolderList;
                })
                .catch(error =>{
                    this.error = error;
                    console.log('Error is ' + this.error);
                });
            
        })
        .catch(error =>{
            this.error = error;
            console.log('Create Folder Error :' , this.error);

        });
        }else{
            createFolder({folderName : this.inputVal , path : ''})
            .then(result =>{
                this.folderResult = result;
                console.log('Folder Response :' , result);

                console.log(JSON.parse(result).id);
                console.log(JSON.parse(result).name);

                let res = JSON.parse(JSON.stringify(this.folder));
                console.log('Folder Data:', res);

                let id ='';
                getData({parentId : id})
                .then(res =>{
                    console.log('result is', res);
                    let tempFileList = [];
                    let tempFolderList = [];
                    for(var i=0; i<res.length; i++){
                        if(res[i].tag == 'folder'){
                            tempFolderList.push(res[i]);
                        }
                        else{
                            tempFileList.push(res[i]);
                        }
                    }
                    this.file = tempFileList;
                    this.folder = tempFolderList;
                })
                .catch(error =>{
                    this.error = error;
                    console.log('Error is ' + this.error);
                });
            
            })
            .catch(error =>{
                this.error = error;
                console.log('Create Folder Error :' , this.error);

            });

        }
        this.isShowModal = false;
        event = new ShowToastEvent({
            title: 'Folder Created',
            message:
                '',
            variant: this.variant,    
                 
        });
        this.dispatchEvent(event);
    }
//====================================== Open Folder =========================================// 
    openFolder(event){
        
        let crumbId = this.myBreadcrumbs[this.myBreadcrumbs.length - 1].id;
        console.log('Breadcrumb id :' + crumbId);

        let crumbName = this.myBreadcrumbs[this.myBreadcrumbs.length - 1].name;
        console.log('Breadcrumb name :' + crumbName);

        let folderId = event.currentTarget.dataset.id;
        console.log('Folder Id :' , folderId);
        let folderPath = event.currentTarget.dataset.name;
        console.log('Path is :' , folderPath);
        this.getFolderId = folderPath;
        console.log('Folder ID!!', this.getFolderId);

        let folderName = event.currentTarget.dataset.value;
        console.log('Folder Name :' , folderName);

        getData({parentId : folderPath})
        .then(res =>{
            console.log('result is', res);
            let tempFileList = [];
            let tempFolderList = [];
            for(var i=0; i<res.length; i++){
                if(res[i].tag == 'folder'){
                    tempFolderList.push(res[i]);
                }
                else{
                    tempFileList.push(res[i]);
                }
            }
            this.file = tempFileList;
            this.folder = tempFolderList;
            
            this.myBreadcrumbs.push({id : folderId , name : folderName});
            console.log('Crumb List :' , this.myBreadcrumbs);
            
        })
        .catch(error =>{
            this.error = error;
            console.log('Error is ' + this.error);
        });

    }
//====================================== Delete Folder =========================================// 
    delFolder(event){
        let folderId = event.currentTarget.dataset.id;
        console.log('Folder Id :' , folderId);
        let delPath = event.currentTarget.dataset.name;
        console.log('del Folder path :' , delPath);
        deleteFolder({path : delPath})
        .then(result =>{
            console.log('Call Delete folder 2');
            this.deleteResult = result;
            console.log('Response From deleteFolder :' , result);
            let folderData = this.folder;
            var index = folderData.findIndex(obj => obj.id == folderId);
            console.log('Index is :' , index);
            folderData.splice(index, 1);
            this.folder = folderData;
            //alert('Folder Deleted');

            const event = new ShowToastEvent({
                title: 'Folder Deleted',
                message:
                    '',
                variant: this.variant,    
                     
            });
            this.dispatchEvent(event);
            
        })
        .catch(error =>{
            this.error = error;
            console.log('Delete folder Error :' , this.error);
        });
        
    }
//====================================== Delete File =========================================//
    delFile(event){
        let fileId = event.currentTarget.dataset.id;
        console.log('Folder Id :' , fileId);
        let delPath = event.currentTarget.dataset.name;
        console.log('del Folder path :' , delPath);
        deleteFolder({path : delPath})
        .then(result =>{
            this.deleteResult = result;
            console.log('Response From deleteFile :' , result);
            let fileData = this.file;
            let fileIndex = fileData.findIndex(obj => obj.id == fileId);
            console.log('File Index is :' , fileIndex);
            fileData.splice(fileIndex, 1);
            this.file = fileData;

            const event = new ShowToastEvent({
                title: 'File Deleted',
                message:
                    '',
                variant: this.variant,    
                     
            });
            this.dispatchEvent(event);
        })
        .catch(error =>{
            this.error = error;
            console.log('Delete File Error :' , this.error);
        });
    }      

//====================================== Download File =========================================//    
    downloadFile(event){
        //let fileId = event.currentTarget.dataset.id;
        let filePath = event.currentTarget.dataset.name;
        downloadDropboxFile({path : filePath})
        .then(result =>{
            console.log('Download File Response :', result);
            let obj = JSON.parse(result);
            console.log('Object :', obj.link);
            let fileLink = obj.link;
            if(fileLink != null){
                window.open(fileLink,'_blank');
                const event = new ShowToastEvent({
                    title: 'File Downloaded',
                    message:'',
                    variant: this.variant,    
                         
                });
                this.dispatchEvent(event);
                
            }
            else{
                const event = new ShowToastEvent({
                    title: 'can\'t Download This File',
                    message:'',
                    variant: 'error',    
                         
                });
                this.dispatchEvent(event);
               // alert('can\'t Download This File');
            }
        })
        .catch(error =>{
            this.error = error;
            console.log('Create Folder Error :' , this.error);
        });
    }
//====================================== Upload File =========================================//   
}