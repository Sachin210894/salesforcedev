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

  handleRowAction(event) {
    console.log("====>actionName");
    const actionName = event.detail.action.name;
    console.log("====>actionName", actionName);

    const row = event.detail.row;
    console.log(
      "====>selectedRows",
      this.template.querySelector("lightning-datatable").getSelectedRows()
    );
    console.log("====>row", row);

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
