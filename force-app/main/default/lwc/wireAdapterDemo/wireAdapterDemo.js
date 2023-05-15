import { LightningElement, api, wire } from 'lwc';
import {getRecord, getFieldValue} from 'lightning/uiRecordApi'; // module : uiRecordApi , which contains two functions i.e. getrecord(getting the record if we pass the record Id) and getFieldValue(fetch the value of perticuler field)
import Name_Field from '@salesforce/schema/Account.Name'; // Imported to references fields
//import Phone_Field from '@salesforce/schema/Account.Phone';
//import Id_Field from '@salesforce/schema/Account.Id';

// Use Object's fields through String 
//  @wire(getRecord, {recordId : '$recordId', fields : ['Account.Name', 'Account.Phone', 'Account.Id']})

//Colection of fileds is also possible in fields
FIELDS = [
    'Account.Name',
    'Account.Phone',
    'Account.Id',

];

export default class WireAdapterDemo extends LightningElement {
    @api recordId;

    /*@wire(getRecord, {recordId : '$recordId', fields : [Name_Field, Phone_Field, Id_Field]})
    record; //data and error

    get name(){
        console.log('DATA :::: ' , this.record.data);
        return this.record.data ? getFieldValue(this.record.data, Name_Field) : '';
    }
    get phone(){
        return this.record.data ? getFieldValue(this.record.data, Phone_Field) : '';

    }
    get Id(){
        return this.record.data ? getFieldValue(this.record.data, Id_Field) : '';
    }*/

    @wire(getRecord, {recordId : '$recordId', fields : FIELDS }) //// ['Account.Name', 'Account.Phone', 'Account.Id'] 
    record; //data and error

    get name(){
        console.log('DATA :::: ' , this.record.data);
        //return this.record.data ? getFieldValue(this.record.data, 'Account.Name') : '';
        return this.record.data.fields.Name.value;
    }
    /*get phone(){
        return this.record.data ? getFieldValue(this.record.data, 'Account.Phone') : '';
       // return this.record.data.fields.Name.value;

    }
    get Id(){
        return this.record.data ? getFieldValue(this.record.data, 'Account.Id') : '';
    }*/
}