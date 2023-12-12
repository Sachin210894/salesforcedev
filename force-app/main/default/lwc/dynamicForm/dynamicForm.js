import { LightningElement, track, wire } from "lwc";
import { getListUi } from "lightning/uiListApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";

export default class DynamicForm extends LightningElement {
  @track selectedFormType = "";
  @track showNameField = false;
  @track showEmailField = false;
  // Add similar tracking variables for other fields

  formTypeOptions = [
    { label: "Select Form Type", value: "" },
    { label: "Name", value: "name" },
    { label: "Email", value: "email" }
    // Add options for other fields
  ];

  @wire(getListUi, {
    objectApiName: ACCOUNT_OBJECT,
    listViewApiName: "AllAccounts"
  })
  accounts;

  get accountList() {
    return this.accounts.data ? this.accounts.data.records.records : [];
  }

  handleFormTypeChange(event) {
    this.selectedFormType = event.detail.value;
    this.showNameField = this.selectedFormType === "name";
    this.showEmailField = this.selectedFormType === "email";
    // Update similar variables for other fields
  }
}
