import { LightningElement, wire } from 'lwc';
import getAccountData from '@salesforce/apex/AccountController.getAllActiveAccounts'; 
import { getListUi } from 'lightning/uiListApi';

import CONTACT_OBJECT from '@salesforce/schema/Contact';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
const columns = [
   { label: 'Name', fieldName: 'Name' },
   
   { label: 'Phone', fieldName: 'phone', type: 'phone' },
   
];

export default class ListView extends LightningElement {
   data = [];
   columns = columns;
   connectedCallback(){
      getAccountData()
      .then(result =>{
         console.log('Result => ', result);
         this.data = result;
         console.log('Data :' , this.data);
      })
      .catch(error =>{
         console.log('ERROR :' , error);
      });
   }
   handleRowAction(){
      alert('inside handleRowAction');
   }
   handleDelete(event) {
      alert('inside handleDelete');
      console.log('Inside handleDelete');
      const selectedRows = event.detail.selectedRows;
      console.log('Selected Rows :' , selectedRows);
      if (selectedRows.length === 0) {
         // Show error message if no rows are selected
         return;
      }
      const recordIds = selectedRows.map(row => row.Id);
      // Use Salesforce REST API to delete the selected records
      deleteRecords(recordIds);
   }
   
//  @wire(getListUi, {
//     objectApiName: CONTACT_OBJECT,
//     listViewApiName: 'All',
//     sortBy: NAME_FIELD,
//     pageSize: 10
// })
// listView;


//  get contacts() {
//     console.log('Contact Records :' , this.listView.data.records);
//     return this.listView.data;
//  }
}