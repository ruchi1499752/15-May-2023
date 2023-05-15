import { LightningElement, track } from 'lwc';
import dropbox_Img from '@salesforce/resourceUrl/auhtorizeDotNet';
export default class PaymentGatewayIntergation extends LightningElement {
    auhtorizeDotNet = dropbox_Img;
    // @track eCheck = ECheck;
    // @track creditCard = CreditCard;
    @track show = false;
    @track showEcheck = true;
    changePayment(){
        //alert("hii");
        this.show = true;
        

    }
    changeToEcheck(){
        //alert('Change');
        this.show = false;
    }

    
}