import { LightningElement } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import contactMC from '@salesforce/messageChannel/ContactMessageChannel__c';
import contactList from '@salesforce/apex/ContactController1.contactList';
const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
];

const columns = [
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'Account Name', fieldName: 'Account.Name', type :'text'},
    
    
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];
export default class ContactList extends LightningElement {
    data = [];
    columns = columns;
    record = {};

    connectedCallback() {
        //this.data = generateData({ amountOfRecords: 100 });
        contactList()
        .then(result =>{
            console.log('Apex Response :', result);
            this.data = result;
        })
        .catch(error =>{
            console.log('Error :' , error);
        });
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'delete':
                this.deleteRow(row);
                break;
            case 'show_details':
                this.showRowDetails(row);
                break;
            default:
        }
    }

    deleteRow(row) {
        const { id } = row;
        const index = this.findRowIndexById(id);
        if (index !== -1) {
            this.data = this.data
                .slice(0, index)
                .concat(this.data.slice(index + 1));
        }
    }

    findRowIndexById(id) {
        let ret = -1;
        this.data.some((row, index) => {
            if (row.id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }

    showRowDetails(row) {
        this.record = row;
    }
}