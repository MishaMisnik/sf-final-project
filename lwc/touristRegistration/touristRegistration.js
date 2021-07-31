import { LightningElement, track, wire } from 'lwc';
import createNewTourist from '@salesforce/apex/TouristRegistrationController.createNewTourist';
import constants from '@salesforce/apex/TouristRegistrationController.getAllConstants';

export default class TouristRegistration extends LightningElement {
    @track firstName;
    @track lastName;
    @track email;
    @track birthday;

    handleClick(event) {
        const int = this.template.querySelectorAll("lightning-input");
        const button = this.template.querySelectorAll("lightning-button");
        
        if (int[0].value && int[1].value && int[2].value && int[3].value) {
            this.firstName = int[0].value;
            this.lastName = int[1].value;  
            this.email = int[2].value;
            this.birthday = int[3].value; 
        } else {
            button[0].variant = 'destructive';
        }

        createNewTourist({firstName: this.firstName, lastName : this.lastName, email : this.email, birthday : this.birthday}).then(result => {
            if (result) {
                button[0].variant = 'success';
                window.location.assign(constants.COMMUNITY_TOURIST_ASSIGNMENT_URL + '?recordId=' + result.Id);
            }
        });

    }
}