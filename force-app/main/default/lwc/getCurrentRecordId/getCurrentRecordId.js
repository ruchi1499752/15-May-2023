import { api, LightningElement , track} from 'lwc';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';

export default class GetCurrentRecordId extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track fields = [FirstName, LastName];

    connectedCallback(){
        console.log('Current Record Id :' , this.recordId);
        console.log('Object API Name :' , this.objectApiName);

    }

}