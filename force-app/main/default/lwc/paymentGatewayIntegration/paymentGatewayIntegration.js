import { LightningElement, track } from 'lwc';
import dropbox_Img from '@salesforce/resourceUrl/auhtorizeDotNet';
import payByCheck from '@salesforce/apex/PaymentGatewayIntegrationController.payByCheck';
import payByCreditCard from '@salesforce/apex/PaymentGatewayIntegrationController.payByCreditCard';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PaymentGatewayIntegration extends LightningElement {
    monthOptions = [
        {
            value: "01",label: "January"
        },
        {
            value: "02", label: "February"
        },
        {
            value: "03", label: "March"
        },
        {
            value: "04",label: "April"
        },
        {
            value: "05",label: "May"
        },
        {
            value: "06",label: "June"
        },
        {
            value: "07",label: "July"
        },
        {
            value: "08",label: "August"
        },
         {
            value: "09",label: "September"
        },
        {
            value: "10",label: "October"
        },
        {
            value: "11",label: "November"
        },
        {
            value: "12",label: "December"
        }
    ];
    yearOptions = [
        {
            value: "2023",label: "2023"
        },
        {
            value: "2024",label: "2024"
        },
        {
            value: "2025",label: "2025"
        },
        {
            value: "2026",label: "2026"
        },
        {
            value: "2027",label: "2027"
        },
        {
            value: "2028",label: "2028"
        },
        {
            value: "2029",label: "2029"
        },
        {
            value: "2030",label: "2030"
        }
    ];

    auhtorizeDotNet = dropbox_Img;
    // @track eCheck = ECheck;
    // @track creditCard = CreditCard;
    @track show = false;
    @track showEcheck = true;
    @track inputVal;
    @track rountingNumber;
    @track accountNumber;
    @track nameOnAccount;
    @track cardNumber;
    @track month;
    @track year;
    @track cvv;
    changePayment(){
        this.show = true;
    }
    changeToEcheck(){
         this.show = false;
    }

    connectedCallback(){
      
    }
    getValue(event){
        if(event.target.name == 'rountingNumber'){
            this.rountingNumber = event.detail.value;
            console.log('RountingNumber :' , this.rountingNumber);
        }else if(event.target.name == 'accountNumber') {
            this.accountNumber = event.detail.value;
            console.log('Account Number is ', this.accountNumber);
        } else if(event.target.name == 'nameOnAccount'){
            this.nameOnAccount = event.detail.value;
            console.log('Name on Account :', this.nameOnAccount);
        }else if(event.target.name == 'cardNumber'){
            this.cardNumber = event.detail.value;
            console.log('Card Number :', this.cardNumber);
        }else if(event.target.name == 'month'){
            this.month = event.target.value;
            console.log('Month :', this.month);
        }else if(event.target.name == 'year'){
            this.year = event.target.value;
            console.log('Year :', this.year);
        }else if(event.target.name == 'cvv'){
            this.cvv = event.target.value;
            console.log('Cvv Number :', this.cvv);
        }

          
    }
    placeOrder(event){
        payByCheck({rountingNum : this.rountingNumber, AccountNum : this.accountNumber , name : this.nameOnAccount})
        .then(result =>{
            console.log('Result is :' , result);
            console.log('typeOf :' , typeof result);
            let transId = result.transactionResponse.transId;
            console.log('TransID :', transId);
            if(transId == 0){
                let errorMsg =  result.transactionResponse.errors[0].errorText;
                console.log('Error Msg :', errorMsg);
                event = new ShowToastEvent({
                    title: errorMsg,
                    message:
                        '',
                    variant: 'Error',    
                        
                });
                this.dispatchEvent(event);

            }else{
                let successMsg = result.transactionResponse.messages[0].description;
                console.log('Success Message :', successMsg); 
                event = new ShowToastEvent({
                    title: successMsg,
                    message:
                        '',
                    variant: 'Success',    
                });
                this.dispatchEvent(event);
            }
        })
        .catch(error =>{
            console.log('Error is :' , error);
        });
    }
    handlePayment(event){
       payByCreditCard({cardNum : this.cardNumber , month : this.month, year : this.year , cvvNum : this.cvv})
        .then(result =>{
            console.log('Response Is :', result);
            let transId = result.transactionResponse.transId;
            console.log('TransID :', transId);
            if(transId == 0){
                let errorMsg =  result.transactionResponse.errors[0].errorText;
                console.log('Error Msg :', errorMsg);
                event = new ShowToastEvent({
                    title: errorMsg,
                    message:
                        '',
                    variant: 'Error',    
                        
                });
                this.dispatchEvent(event);

            }else{
                let successMsg = result.transactionResponse.messages[0].description;
                console.log('Success Message :', successMsg); 
                event = new ShowToastEvent({
                    title: successMsg,
                    message:
                        '',
                    variant: 'Success',    
                });
                this.dispatchEvent(event);
            }

            
        })
        .catch(errro =>{
            console.log('Error :', errro);
        });
    }
    

    
}
// let obj = (JSON.parse(JSON.stringify(result)));
            // let obj = {result};
            //console.log('***************', obj);
// var res = JSON.stringify(result);
            // console.log('Stringfy :', res);
            // if(res.includes('errors')){
            //     event = new ShowToastEvent({
            //         title: 'The transaction was unsuccessful.',
            //         message:
            //             '',
            //         variant: 'Error',    
                        
            //     });
            //     this.dispatchEvent(event);
               
            // }
            // else{
            //     event = new ShowToastEvent({
            //         title: 'The transaction was successful.',
            //         message:
            //             '',
            //         variant: 'Success',    
                        
            //     });
            //     this.dispatchEvent(event);
            // }