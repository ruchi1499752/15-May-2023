import { LightningElement } from 'lwc';
import bootstrap from '@salesforce/resourceUrl/Bootstrap';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import jquery from '@salesforce/resourceUrl/jquery';
export default class BootstrapDemo extends LightningElement { 
    renderedCallback() {
        Promise.all([
            loadStyle(this, bootstrap + '/bootstrap-5.0.2-dist/css/bootstrap.min.css'),
           
            loadScript(this, bootstrap + '/bootstrap-5.0.2-dist/js/bootstrap.js'),
            //loadScript(this, popper),
            loadScript(this, jquery)     
        ])
        .then(() => {
            console.log("All scripts and CSS are loaded. perform any initialization function.")
        })
        .catch(error => {
            console.log("failed to load the scripts");
        });
       /* .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    //message: 'Third-Party Libraries Loaded',
                    variant: 'success',
                }),
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error Loading Third-Party Libraries',
                   // message: error.message,
                    variant: 'error',
                }),
            );
        });*/
    }
}
/*import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import jquery from '@salesforce/resourceUrl/jquery';
import bootstrap1 from '@salesforce/resourceUrl/bootstrap';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
//import popper from '@salesforce/resourceUrl/popper';

export default class Test extends LightningElement { 

    renderedCallback() {
        alert('inside renderdcallback');
        Promise.all([
            loadStyle(this, bootstrap1 + '/css/bootstrap.css'),
           
            loadScript(this, bootstrap1 + '/js/bootstrap.js'),
            //loadScript(this, popper),
            loadScript(this, jquery)     
        ])
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        //message: 'Third-Party Libraries Loaded',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Loading Third-Party Libraries',
                       // message: error.message,
                        variant: 'error',
                    }),
                );
            });

    }
}*/
/*import { LightningElement } from 'lwc';
import bootstrap from '@salesforce/resourceUrl/bootstrap';
import jquery from '@salesforce/resourceUrl/jquery';
import {loadStyle, loadScript} from 'lightning/platformResourceLoader';
export default class BootstrapDemo extends LightningElement {
    renderedCallback(){
        Promise.all([
            loadScript(this, bootstrap + '/js/bootstrap.js'),
           loadScript(this, jquery),
            loadStyle(this, bootstrap + '/css/bootstrap.min.css')
        ])
        // .than(()=>{
        //     console.log('Bootstrap is working fine');
        // }
        // )
    }
}*/