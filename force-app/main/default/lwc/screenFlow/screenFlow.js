import { LightningElement,track,api } from 'lwc';
import getCase from '@salesforce/apex/ScreenFlowController.getCase';
export default class ScreenFlow extends LightningElement {

    @track name = 'Ruchi';
    connectedCallback(){
        getCase()
        .then(result =>{
            console.log('Apex Response : ' , result);
            
        })
        .catch(error =>{
            console.log('Apex Error :' , error);
        });
    }

}