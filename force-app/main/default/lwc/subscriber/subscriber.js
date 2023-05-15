import { LightningElement,track,wire } from 'lwc';
import { publish, subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import AccData from '@salesforce/messageChannel/SampleMessageChannel__c';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import BILLINGCITY_FIELD from '@salesforce/schema/Account.BillingCity';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import RATING from '@salesforce/schema/Account.Rating';

export default class Subscriber extends LightningElement {
    //context = createMessageContext();
    @wire(MessageContext)
    messageContext;
    receiveMessage;x
    subscription = null;
    @track accountId;
    @track objectApiName = 'Account';
    @track fields = [NAME_FIELD, BILLINGCITY_FIELD, INDUSTRY_FIELD, RATING];

    connectedCallback(){
        console.log('Inside Connected Callback');
        //this.subscribeMC();
        this.subscription = subscribe(this.messageContext, AccData, (message) =>{this.handleMessage(message) },{ scope: APPLICATION_SCOPE });
    }

    // subscribeMC(){
    //     console.log('Inside subscribeMC');
    //     if(this.subscription){
    //         return;
    //     }
    //     this.subscription = subscribe(this.messageContext, AccData, (message) =>{this.handleMessage(message) },{ scope: APPLICATION_SCOPE });
    // }

    handleMessage(message){
        console.log('Inside handleMessage');
        console.log('Hii from HandleMessage ', JSON.stringify(message));
        this.accountId = message.recordId;
        this.receiveMessage = message ? message.recordData.value : 'No Message Payload';

        console.log('AccountId :' , this.accountId);
        console.log('ReceiveMessage :' , this.receiveMessage);
    }
}