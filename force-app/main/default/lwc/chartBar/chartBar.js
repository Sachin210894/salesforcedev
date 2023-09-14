import { LightningElement,api,track } from 'lwc';
export default class ChartBar extends LightningElement {

 @api percentage = 20;

@track percent =0;
 
submit(event){
 this.percent = event.target.value;

 if(this.percent >100){

     alert('Value cant be greater than 100');
      console.log('test this',this.percent);
     this.percent = 0;

 }
 
}
    get style() {

       
        return `width: ${this.percent}%`;
    }
}