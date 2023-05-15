import { LightningElement,track ,wire} from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

 // columns
const columns = [
    {
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
    }, {
        label: 'FirstName',
        fieldName: 'FirstName',
        type: 'text',
        editable: true,
    }, {
        label: 'LastName',
        fieldName: 'LastName',
        type: 'text',
        editable: true,
    }, {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
        editable: true
    }
];

export default class CustomInlineEditingLWC extends LightningElement {
    columns = columns;
    @track contacts;
    saveDraftValues = [];
 
    @wire(getContacts)
    contactData(result) {
        this.contacts = result;
        if (result.error) {
            this.contacts = undefined;
        }
    };
 
    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });
 
        // Updateing the records using the UiRecordAPi
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.ShowToast('Success', 'Records Updated Successfully!', 'success', 'dismissable');
            this.saveDraftValues = [];
            return this.refresh();
        }).catch(error => {
            this.ShowToast('Error', 'An Error Occured!!', 'error', 'dismissable');
        }).finally(() => {
            this.saveDraftValues = [];
        });
    }
 
    ShowToast(title, message, variant, mode){
        const evt = new ShowToastEvent({
                title: title,
                message:message,
                variant: variant,
                mode: mode
            });
            this.dispatchEvent(evt);
    }
 
    // This function is used to refresh the table once data updated
    async refresh() {
        await refreshApex(this.contacts);
    }


    // @track data = [
    //     { id: 1, name: 'Record 1', value: 'Value 1', isEditable: false },
    //     { id: 2, name: 'Record 2', value: 'Value 2', isEditable: false },
    //     { id: 3, name: 'Record 3', value: 'Value 3', isEditable: false },
    // ];

    // handleCellChange(event) {
    //     alert();
    //     const updatedData = [...this.data];
    //     console.log('updateData :: ', updatedData);
    //     const rowIndex = event.target.closest('tr').dataset.rowIndex;
    //     updatedData[rowIndex].value = event.target.value;
    //     updatedData[rowIndex].isEditable = false;
    //     this.data = updatedData;
    // }

    // handleSaveClick() {
    //     // Send the updated data to the server for further processing
    // }
    /*@track isEditable = false;
    @track tableData = [
        {
          Id: 1,
          field1: 'Value 1',
          field2: 'Value 2',
          field3 : 'value 3',
          //isEditable : false
        }
    ]  
    
    handleInputChange(event){
        this.field1 = event.target.value;
        console.log('fieldvalue ::' , this.field1);


    }
    handleRowClick(){
        alert('Call handleClick');
        this.isEditable = true;
    }*/
    // @track fieldValue = 'Default Value';
  
    // handleClick() {
    //   this.isEditable = true;
    // }
  
    // handleInputChange(event) {
    //   this.fieldValue = event.target.value;
    //   console.log('fieldvalue ::' , this.fieldValue);
    // }
  }