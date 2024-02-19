import { LightningElement, wire, track } from "lwc";
import fetchAccounts from "@salesforce/apex/getmapaccount.fetchAccounts";

export default class L_map extends LightningElement {
  @track error;
  @track mapMarkers = [];
  @track markersTitle = "Accounts";
  @track zoomLevel = 2;

  /* Load address from Controller */
  @wire(fetchAccounts, {})
  wireAccount({ error, data }) {
    if (data) {
      data.forEach((dataItem) => {
        this.mapMarkers = [
          ...this.mapMarkers,
          {
            location: {
              City: dataItem.BillingCity,
              Country: dataItem.BillingCountry
            },
            icon: "custom:custom26",
            title: dataItem.Name
          }
        ];
      });
      this.error = undefined;
    } else if (error) {
      this.error = error;
    }
  }
}
