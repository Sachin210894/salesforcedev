import { LightningElement, track } from "lwc";

export default class Funnyjoke extends LightningElement {
  @track newjoke;
  @track newjoke2;

  async handleClick() {
    const response = await fetch(
      "https://official-joke-api.appspot.com/jokes/random"
    );
    const items = await response.json();
    console.log("new joke", JSON.stringify(items));
    this.newjoke = JSON.stringify(items.setup);
    this.newjoke2 = JSON.stringify(items.punchline) + "😂😊😂";
  }

  clear() {
    this.newjoke = null;
    this.newjoke2 = null;
  }
}