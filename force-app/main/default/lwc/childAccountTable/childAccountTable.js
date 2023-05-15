import { LightningElement , wire, api,track} from 'lwc';
import getdata from '@salesforce/apex/CustomAccountController.getAccountData';
const columns = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Date', fieldName: 'Rating_Date__c', type: 'Date', editable: true },
   
]


export default class ChildAccountTable extends LightningElement {
  
    columns = columns;
    @track data = [];
    connectedCallback(){
        getdata()
        .then(result =>{
            console.log('Result =>' , result);
            this.data = result;
            console.log('Data 1 ::', this.data);
            this.data = JSON.parse(JSON.stringify(result));
            console.log('Data 2  :: ', this.data);
        })
        .catch(error =>{
            console.log('error => ', error);
        })
    }
    handleSave(){
        console.log('Inside handle save');
        const saveEvent = new CustomEvent('save');
        this.dispatchEvent(saveEvent);
    }
}