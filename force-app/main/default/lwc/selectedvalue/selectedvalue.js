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

  connectedCallback() {
    this.data = generateData({ amountOfRecords: 100 });
  }

  handleRowAction() {
    var el = this.template.querySelector("lightning-datatable");
    var selected = el.getSelectedRows();
    console.log("new selected", selected);

    this.record = JSON.stringify(selected);
    console.log(el);
    console.log("new Debug", this.record);

    console.log("new Debug -=-1", this.record.name);

    /* switch (actionName) {
            case 'delete':
                this.deleteRow(row);
                break;
            case 'show_details':
                this.showRowDetails(row);
                break;
            default:
        }*/
  }
}
