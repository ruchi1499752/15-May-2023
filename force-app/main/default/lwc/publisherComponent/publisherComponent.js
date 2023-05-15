import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ACCOUNT_CHANNEL from "@salesforce/messageChannel/AccountMessageChannel__c";

export default class PublisherComponent extends LightningElement {
    //2. Wiring the MessageContext to a property
    @wire(MessageContext)
    msgContext;

    //3. Handling the user input. that is button click
    handleClick(){
        alert('hii from handle Click');
        const messaage = {
            recordId: "0015j00000jncr2AAA",
            name: "Ronak Sharma"
        };

    //4. Publishing the message
    publish(this.msgContext, ACCOUNT_CHANNEL, messaage);
    }

}