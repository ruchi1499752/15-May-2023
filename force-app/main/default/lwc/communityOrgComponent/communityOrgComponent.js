import { LightningElement,track } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAllFiles from '@salesforce/apex/CommunityOrgController.getAllFiles';
import fileUpload from '@salesforce/apex/CommunityOrgController.fileUpload';
import uploadFileToApiOrg from '@salesforce/apex/CommunityOrgController.uploadFileToApiOrg';
export default class CommunityOrgComponent extends LightningElement {
    @track ShowUploadFileModal;
    @track isShowModal;
    @track allFiles;
    fileData;
    @track showSpinner = true;
    connectedCallback(){
        getAllFiles()
        .then(result =>{
            console.log('All Files : Result :', result);
            this.allFiles = result;
            console.log('All Files :', this.allFiles);

        })
        .catch(error =>{
            
            console.log('Error is ' + this.error);
        });
        //showSpinner = false;
    }
    
    uploadModal(){
        this.ShowUploadFileModal = true;
    }
    hideModalBox(){
        this.isShowModal = false;
        this.ShowUploadFileModal = false;
    }
    handleFileUploaded(event){
        let file = event.target.files[0];
        console.log('Getting File Details:' , file);
        console.log('=====================================');
        let fName = file.name;
        console.log('File NAme :' , fName);
        let fileType = file.type;
        console.log('File Type' , fileType);

        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'Title': file.name,
                'base64': base64,
                'recordId': '0035j00000RMYGAAA5',
                'FileType' : file.type
            }
            console.log('File Data : ', this.fileData);
            this.allFiles.push(this.fileData);
            console.log('All Files ::::', this.allFiles);


            fileUpload({base64 : base64, filename : file.name})
            .then(result =>{
                console.log('Result is : ' ,result);
            })
            .catch(error =>{
                console.log('ERROR :', error);
            });

            uploadFileToApiOrg({base64 : base64, filename : file.name})
            .then(result =>{

                console.log('Result is :====> ' ,result);
            })
            .catch(error =>{
                console.log('ERROR :', error);
            });

        }
        reader.readAsDataURL(file);

        showSpinner = false;
        this.ShowUploadFileModal = false;
        event = new ShowToastEvent({
            title: 'File upload SuccessFully',
            message:
                '',
            variant: 'Success',    
                 
        });
        this.dispatchEvent(event);


    }

    
   
}