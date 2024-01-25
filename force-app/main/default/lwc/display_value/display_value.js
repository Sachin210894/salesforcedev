import { LightningElement, track } from "lwc";
export default class Display_value extends LightningElement {
  @track selectedFormType = "";
  @track name;
  labelValue = "";
  fieldValue = "";

  formTypeOptions = [
    { label: "Select Form Type", value: "" },
    { label: "Text", value: "text" },
    { label: "Number", value: "number" },
    { label: "Auto-Number", value: "autonumber" },
    { label: "phone", value: "phone" },
    { label: "URL", value: "url" }
  ];

  handleFormTypeChange(event) {
    this.selectedFormType = event.detail.value;
    // console.log('Value is:',this.selectedFormType);
  }

  displayfield(event) {
    this.fieldValue = event.target.value;
    this.labelValue = this.fieldValue + "__c";
    // this.name= event.target.value;
    //  console.log('Name is:',this.name);
  }

  // displaylabel(event) {
  //     this.label= event.target.value +'__c' ;
  //   //   console.log('Name1 is:',this.label);
  // }

  handleSubmit() {
    console.log("Selected Form Type:", this.selectedFormType);
    console.log("Field Name:", this.fieldValue);
    console.log("Label:", this.labelValue);
  }
}
