import { LightningElement, wire,track} from 'lwc';
import { publish, MessageContext, subscribe } from 'lightning/messageService';
//import {subscribe,unsubscribe,APPLICATION_SCOPE,MessageContext, publish } from 'lightning/messageService';

import MyMessageChannel from '@salesforce/messageChannel/SampleMessageChannel__c';
export default class LMSComponent1 extends LightningElement {
    @track subscription ;
    @track mssg;

    @track message = {
        recordId: "0015j00000jncr2AAA",
        name: "Ronak Sharma"
    };
    @wire(MessageContext)
    messageContext;


    handleClick(){
        console.log('hii from handle Click');
        const message = {
            recordId: "0015j00000jncr2AAA",
            name: "Ronak Sharma"
        };
        console.log('Message :' , message);

    //4. Publishing the message :  publishes an event 
    publish(this.messageContext, MyMessageChannel, message);
    }

    connectedCallback(){
        console.log('hi from receiveMsg');  
        //subscribe(this.messageContext, MyMessageChannel, (messaage) => { this.handleMessage(message)});

        this.subscription = subscribe(this.messageContext, MyMessageChannel, (param) => { this.handleMessage(param)});
    }
    handleMessage(param){
        console.log('Hii from handleMessage 2');
        this.mssg = param.msg;
        console.log('Message2:::::', this.mssg);
        
    }
}