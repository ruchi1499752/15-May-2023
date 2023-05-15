import { LightningElement,track,api  } from 'lwc';
import { Spinner } from 'lightning/spinner';

export default class AccountParentComponent extends LightningElement {
    @track accountId = '0015j00000XuveNAAR';
    show = false;
    editData = true;
    showSpinner = false;
    @track showEditButton = true;
    @track showSaveButton = false;

    connectedCallback(){
        this.show = true;
    }
    handleEdit(){
        this.editData = false;
        this.showEditButton = false;
        this.showSaveButton = true;
    }
    handleSave(event){
    
        this.editData = true;
        this.showEditButton = true;
        this.showSaveButton = false;
        
        const getAccountData = this.template.querySelector('c-account-child-component');
        getAccountData.handlesaveData();

        // const getContactData = this.template.querySelector('c-contact-child-component');
        // getContactData.handlesaveData();

        // const getCaseData = this.template.querySelector('c-case-child-component');
        // getCaseData.handlesaveData();

        // const getContractData = this.template.querySelector('c-contract-child-component');
        // getContractData.handlesaveData();
        // this.showSpinner = true;
        // this.showSpinner = false;
    }
}