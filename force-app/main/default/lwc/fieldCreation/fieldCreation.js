import { LightningElement, wire } from "lwc";
import getPicklistValues from "@salesforce/apex/Sobjectist.getSObjectNames";

export default class FieldCreation extends LightningElement {
  selectedSObject;
  sObjectOptions = [];

  @wire(getPicklistValues)
  wiredSObjects({ error, data }) {
    if (data) {
      // Format the data for lightning-combobox
      this.sObjectOptions = data.map((name) => ({ label: name, value: name }));
    } else if (error) {
      console.error("Error fetching SObjects", error);
    }
  }

  handleSObjectChange(event) {
    this.selectedSObject = event.detail.value;
    // Handle the selected SObject as needed
  }
}
