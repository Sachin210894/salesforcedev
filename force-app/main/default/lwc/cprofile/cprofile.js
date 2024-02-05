import { LightningElement, wire } from "lwc";

import USER_ID from "@salesforce/user/Id";
import { getRecord } from "lightning/uiRecordApi";
import UserNameFIELD from "@salesforce/schema/User.Name";
import userEmailFIELD from "@salesforce/schema/User.Email";
import userIsActiveFIELD from "@salesforce/schema/User.IsActive";
import userAliasFIELD from "@salesforce/schema/User.Alias";

export default class Cprofile extends LightningElement {
  currentUserName;
  currentUserEmail;
  currentIsActive;
  currentUserAlias;

  @wire(getRecord, {
    recordId: USER_ID,
    fields: [UserNameFIELD, userEmailFIELD, userIsActiveFIELD, userAliasFIELD]
  })
  currentUserInfo({ error, data }) {
    if (data) {
      this.currentUserName = data.fields.Name.value;
      this.currentUserEmail = data.fields.Email.value;
      this.currentIsActive = data.fields.IsActive.value;
      this.currentUserAlias = data.fields.Alias.value;
    } else if (error) {
      this.error = error;
    }

    console.log(
      "this.user.data.fields.Name.value",
      this.currentUserName +
        " ---" +
        this.currentUserEmail +
        " ---" +
        this.currentUserAlias +
        " ---" +
        this.currentIsActive
    );
  }
  /* @wire(getRecord, { recordId: '$userId', fields: FIELDS })
    user;

    get userName() {
        return this.user.data.fields.Name.value;
    }

    get userEmail() {
        console.log('this.user.data.fields.Email.value',this.user.data.fields.Email.value);

        return this.user.data.fields.Email.value;
    }

    get userPhone() {
        return this.user.data.fields.Phone.value;
    }

    get userRole() {
        return this.user.data.fields.Profile.value.fields.Name.value;
    }

    get userAvatarUrl() {
        return '/profile/' + this.user.data.fields.Alias.value;
    }

    get userAddress() {
        return this.user.data.fields.Address__c.value;
    }*/
}
