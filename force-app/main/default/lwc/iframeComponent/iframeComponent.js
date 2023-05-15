import { LightningElement,api,track } from 'lwc';
import Store_url from '@salesforce/label/c.Store_url';

  

export default class IframeComponent extends LightningElement {

    @track videosByMonth = [
        {
          month: 'January',
          urls: [
            'https://www.youtube.com/embed/68X85SxAU1g',
            'https://www.youtube.com/embed/68X85SxAU1g'
          ]
        },
        {
          month: 'February',
          urls: [
            'https://www.youtube.com/embed/68X85SxAU1g',
            'https://www.youtube.com/embed/68X85SxAU1g'
          ]
        },
        // and so on for each month
      ];
  
    @track  iframeRef;

      connectedCallback() {
        this.iframeRef = this.template.querySelector('iframe');
        console.log('Conected Callback iframeRef :' , this.iframeRef);
      }
  
      handleMonthChange(event) {
        const selectedMonth = event.target.value;
        console.log('Selected Month :' , selectedMonth);
        const monthObject = this.videosByMonth.find(month => month.month === selectedMonth);
        console.log('monthObject: ', monthObject);
        const randomUrl = monthObject.urls[Math.floor(Math.random() * monthObject.urls.length)];
        console.log('RandomUrl :' , randomUrl);
        this.iframeRef.src = randomUrl;
        console.log('IframREf :' , this.iframeRef);
      }

    //   connectedCallback() {
    //     this.videoRef = this.template.querySelector('iframe');
    //     console.log('videoRef :: ', this.videoRef);

    //   }
  
    //   handleMonthChange(event) {
    //     // const selectedMonth = event.target.value;
    //     // console.log('selected Month ::' , selectedMonth);
    //     // const monthObject = this.videosByMonth.find(month => month.month === selectedMonth);
    //     // console.log('monthObject :' , monthObject);
    //     // const randomUrl = monthObject.urls[Math.floor(Math.random() * monthObject.urls.length)];
    //     // console.log('Random Url :' , randomUrl);
    //     // this.videoRef.src = randomUrl;
    //     // console.log('video ref :' , this.videoRef);
    //     // this.videoRef.play();
    //   }

//     @api url = Store_url;
//     currentMonth = "January";
//   currentVideoUrl = urls[0].videoUrls[0];

//   handleMonthChange(event) {
//     this.currentMonth = event.target.value;
//     console.log('Current Month :', this.currentMonth);
//     const currentMonthUrls = urls.find(urlObj => urlObj.month === this.currentMonth);
//     console.log('currentMonthUrls :' , currentMonthUrls);
//     this.currentVideoUrl = currentMonthUrls.videoUrls[0];
//     console.log('currentVideoUrl ::' , this.currentVideoUrl);
//   }
}