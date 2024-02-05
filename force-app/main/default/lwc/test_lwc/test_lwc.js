import { LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";

export default class Test_lwc extends NavigationMixin(LightningElement) {
  navigatetocandidate() {
    // alert('CLicked');

    this[NavigationMixin.Navigate]({
      type: "comm__namedPage",
      attributes: {
        pageName: "candidate"
      }
    });
  }

  navigatetocustomer() {
    //   alert('CLicked');

    this[NavigationMixin.Navigate]({
      type: "comm__namedPage",
      attributes: {
        pageName: "customer"
      }
    });
  }
}
