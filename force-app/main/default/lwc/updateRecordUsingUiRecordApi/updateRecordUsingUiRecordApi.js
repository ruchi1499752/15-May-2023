import { LightningElement,api,wire } from 'lwc';
import {getRecord, getFieldValue, updateRecord} from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import Opp_Name_Field  from '@salesforce/schema/Opportunity.Name';
import Account_Name_Field from '@salesforce/schema/Opportunity.Account.Name';   
import Account_Id_Field  from '@salesforce/schema/Opportunity.Account.Id';

const fields = [Opp_Name_Field, Account_Name_Field, Account_Id_Field];

export default class UpdateRecordUsingUiRecordApi extends LightningElement {
    @api recordId; // get the current record id
    accName;

    // Wire method to get the data of fields
    @wire(getRecord, {recordId : '$recordId' , fields})
    opp;

    handleText(event){
        
        let aName1 = event.target.value;
        console.log('aNAme1 : ' , aName1);
        this.accName = aName1;
        console.log('accNAme Ruciiiiiiiiiiiiiii: ' , this.accName);

    }
    updateAccount(event){

        console.log('Opportunity Data : ' , this.opp.data);
        /*
        * we can access field values directly referencing the value
        * or you can use also use getFieldValue to get the value
        */
        
        let oppName = getFieldValue(this.opp.data, Opp_Name_Field);
        console.log('Opp Name  :- ' , oppName);
        let accountId = getFieldValue(this.opp.data, Account_Id_Field);
        console.log('Account ID :' , accountId);
        let accountName = getFieldValue(this.opp.data, Account_Name_Field);
        console.log('Account Name : ' , accountName);

        console.log('Input field Text : ', this.accName);

        let fields = {
            Id: accountId,
            Name: this.accName
        }
        const recordInput = { fields };
        updateRecord(recordInput)
        .then(() =>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!',
                    message: 'Account name updated successfully',
                    variant: 'success'
                })
            )
        })
        .catch(error =>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!',
                    message: 'Something went wrong while updating account',
                    variant: 'error'
                })
            )
        });
    }

    // Opp Name  :-  GenePoint Lab Generators
    // Account ID : 0015j00000XuveNAAR
    // Account Name :  GenePoint

}