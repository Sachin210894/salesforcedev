import { LightningElement, track } from "lwc";

export default class Display_value extends LightningElement {
  @track selectedFormType = "";
  @track labelValue = "";
  @track fieldValue = "";
  @track error = "";

  formTypeOptions = [
    { label: "Select Field Type", value: "" },
    { label: "Text", value: "text", regex: /^[\s\S]*$/ },
    { label: "Number", value: "number", regex: /^\d+$/ },
    { label: "Auto-Number", value: "autonumber", regex: /^\d+$/ },
    { label: "Phone", value: "phone", regex: /^\+?\d+$/ },
    { label: "URL", value: "url", regex: /^(ftp|http|https):\/\/[^ "]+$/ },
    { label: "Email", value: "email", regex: /^[^\s@]+@[^\s@]+\.[^\s@]+$/ }
  ];

  handleFormTypeChange(event) {
    this.selectedFormType = event.detail.value;
    this.resetError();
  }

  handleFieldChange(event) {
    this.fieldValue = event.target.value;
    this.labelValue = this.fieldValue + "__c";
    this.resetError();
  }

  resetError() {
    this.error = "";
  }

  handleSubmit() {
    const formType = this.formTypeOptions.find(
      (option) => option.value === this.selectedFormType
    );

    if (formType && formType.regex) {
      if (!formType.regex.test(this.fieldValue)) {
        this.error = `Please enter a valid ${formType.label} value.`;
        return;
      }
    }

    console.log("Selected Form Type:", this.selectedFormType);
    console.log("Field Name:", this.fieldValue);
    console.log("Label:", this.labelValue);
    this.resetError();
  }
}
