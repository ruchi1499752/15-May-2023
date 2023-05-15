import { LightningElement, track,wire,api} from 'lwc';
import {subscribe,unsubscribe,APPLICATION_SCOPE,MessageContext, publish } from 'lightning/messageService';
import MyMessageChannel from '@salesforce/messageChannel/SampleMessageChannel__c';
export default class LMSComponent2 extends LightningElement {
    @wire(MessageContext)
    messageContext;

    @track recId;
    @track name ;
    @track param = {
        msg : 'Lightning Message Service'
    }
    //@track msg = 'Lightning Message Service';
    @track subscription ;

    connectedCallback(){
        console.log('hi from receiveMsg');
        //subscribe(this.messageContext, MyMessageChannel, (messaage) => { this.handleMessage(message)});

        this.subscription = subscribe(this.messageContext, MyMessageChannel, (message) => { this.handleMessage(message)});
    }

    handleMessage(message){
        console.log('Hii from handleMessage');
        this.recId = message.recordId;
        this.name = message.name;

        console.log('Record ID : ', this.recId);
        console.log('Name : ' , this.name);

    }
    sendReceiverMsg(){
        alert('hii from sendReceiverMsg');
        const param = {
            msg : 'Lightning Message Service'
        }
        console.log('Msg ::::' , param);

        publish(this.messageContext, MyMessageChannel, param);
    }







}