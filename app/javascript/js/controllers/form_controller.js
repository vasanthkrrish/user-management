import { Controller } from "@hotwired/stimulus";
import Noty from 'noty';
import 'noty/src/noty.scss'
import 'noty/src/themes/bootstrap-v4.scss'

export default class extends Controller {
    static targets = ['form'];

    submitForm(event) {
        if (event.target.type === 'submit') {
            const password = this.formTarget.querySelector("input[id='user_password']");
            const password_confirm = this.formTarget.querySelector("input[id='user_password_confirmation']");
            const email = this.formTarget.querySelector("input[type='email']");
            const contact = this.formTarget.querySelector("input[id='user_contact']");
            let isValid = this.validateForm(this.formTarget);
            if (password) {
                isValid = isValid && this.validatePassword(password.value, 'Password');
                if (password_confirm) {
                    isValid = isValid && this.validatePassword(password_confirm.value, 'Password Confirmation');
                    if (password.value !== password_confirm.value) {
                        this.notify('Password and Confirmation does not match')
                    }
                }
            }
            if (email && email.required) {
                const emailValid = this.validateEmail(email.value);
                if (!emailValid) {
                    this.notify('Provide valid email address');
                }
                isValid = isValid && emailValid;
            }
            if (contact && contact.value.length > 0) {
                if (!/[0-9]/g.test(contact.value)) {
                    this.notify('Contact should be only numeric');
                    isValid = isValid && false;
                } else if (contact.value.length < 10) {
                    this.notify('Contact length should be atleast 10');
                    isValid = isValid && false;
                }
            }
            if (!isValid) {
                event.preventDefault();
            }
        }
    }

    validateForm() {
        let isValid = true;

        // Tell the browser to find any required fields
        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.formTarget.querySelectorAll(requiredFieldSelectors);

        requiredFields.forEach((field) => {
            // For each required field, check to see if the value is empty
            // if so, we focus the field and set our value to false
            if (!field.disabled && !field.value.trim()) {
                if (field.title && field.type !== "email") {
                    this.notify(field.title + ' can not be blank');
                }
                field.focus();

                isValid = false;
            }
        });

        return isValid;
    }

    validatePassword(value, symbol) {
        let isValid = true;
        if (value.length > 8) {
            if (!this.isStrong(value)) {
                this.notify( symbol + ' must be a mix of letters(uppercase and lowercase), numbers, and symbols');
                isValid = false;
            }
        } else {
            this.notify(symbol + ' must be minimum 8 characters length');
            isValid = false;
        }
        return isValid;
    }

    validateEmail(str) {
        const re = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;
        return re.test(str);
    }

    isStrong(str) {
        const re = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
        return re.test(str);
    }

    notify(str) {
        new Noty({
            text: str,
            type: 'error',
            theme: 'bootstrap-v4',
            progressBar: true,
            timeout: 3000,
        }).show();
    }
}
