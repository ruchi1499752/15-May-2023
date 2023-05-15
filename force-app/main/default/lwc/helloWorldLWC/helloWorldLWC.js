import { api, LightningElement } from 'lwc';
import id from '@salesforce/user/Id';

export default class HelloWorld extends LightningElement {
    greeting = 'World';
    @api name ='Ruchi';
    userid = id;
    Name  = 'Brisminsds';
    @api Course = 'BCA';

    
  changeHandler(event) {
    this.greeting = event.target.value;
  }

  handleClick(){
    alert("hii from JS");
    console.log("Hii LWC");
    this.greeting = 'dfdf';
    this.name = 'Ruchi Chourasia';
    console.log('Name is :' , this.name);
    console.log('Current User Id :' , this.userid);
    console.log(this.Course);

  }
}