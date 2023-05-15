import { LightningElement, track } from 'lwc';

export default class BikeCard extends LightningElement {
  name = 'Electra X4';
  description = 'A sweet bike built for comfort.';
  category = 'Mountain';
  material = 'Steel';
  price = '$2,700';
  pictureUrl = 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg';
  @track colors = ['Red','Green', 'Blue'];
  @track address = {
    City : 'Jaipur',
    pincode : 305001,
    country : 'India'
  }

  connectedCallback(){
    this.address = 'Ajmer';
    console.log('Addresss :' , this.address);
  }
  handleChange(event){
    alert('Hii from handleChange');
    this.colors[0] = event.target.value; 
    console.lof('Color NAme is :' , this.colors[0]);
  }
}