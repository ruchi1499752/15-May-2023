import { LightningElement , track, wire} from 'lwc';
import getAccoutData from '@salesforce/apex/LMSAccountController.getAccoutData';
import { publish, subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import AccData from '@salesforce/messageChannel/SampleMessageChannel__c';
export default class Publish extends LightningElement {
    //context = createMessageContext();
    @wire(MessageContext)
    messageContext;
    @track AccList;

    connectedCallback(){
        getAccoutData()
        .then(result =>{
            this.AccList = result;
            console.log('Account List : ' , this.AccList);
        })
        .catch(error =>{
            console.log('Error :', error);
        });
        
    }
    
    handleClick(event){
        event.preventDefault();
        console.log('inside handleClick');
        const message ={
            recordId : event.target.dataset.value,
            recordData : {value : "message from Lightning Web Component"}
        };
        console.log('Message :', message);
        console.log('Record Id :', message.recordId);
        console.log('Record Data :', message.recordData);
        publish(this.messageContext, AccData, message);
        console.log('Exit from handleClick Method');


    }


}