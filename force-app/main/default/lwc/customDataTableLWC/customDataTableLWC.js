import { LightningElement, track } from 'lwc';
import getData  from '@salesforce/apex/LWCExampleController.getContacts';

export default class CustomDataTableLWC extends LightningElement {
    @track data = [];
    connectedCallback(){
        getData()
        .then(result =>{
            console.log('Result => ', result);
            this.data = result;
            console.log('Data = >' , JSON.stringify(this.data));
            console.log('Data = >' , JSON.parse(JSON.stringify(this.data)));
        })
        .catch(error =>{
            console.log('Error => ', error);
        })
    }
}
// JSON.stringify() takes a JavaScript object and then transforms it into a JSON string.
// JSON.parse() takes a JSON string and then transforms it into a JavaScript object.