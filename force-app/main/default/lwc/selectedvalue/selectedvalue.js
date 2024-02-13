import { LightningElement } from "lwc";
import generateData from "./generateData.js";

const actions = [
  { label: "Show details", name: "show_details" },
  { label: "Delete", name: "delete" }
];

const columns = [
  { label: "Name", fieldName: "name" },
  { label: "Website", fieldName: "website", type: "url" },
  { label: "Phone", fieldName: "phone", type: "phone" },
  { label: "Balance", fieldName: "amount", type: "currency" },
  { label: "Close At", fieldName: "closeAt", type: "date" },
  {
    type: "action",
    typeAttributes: { rowActions: actions }
  }
];
export default class Selectedvalue extends LightningElement {
  data = [];
  columns = columns;
  record = {};
  newlist ;

  connectedCallback() {
    this.data = generateData({ amountOfRecords: 100 });
  }
  getSelected() {
    console.log("getSelectedRows => ", this.template.querySelector('lightning-datatable').getSelectedRows());
}
  handleRowAction = event => {
    var selectedRows=event.detail.selectedRows;
    console.log(JSON.stringify(selectedRows));
    this.newlist = JSON.stringify(selectedRows);

  }
}