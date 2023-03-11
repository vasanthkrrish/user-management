import { Controller } from "@hotwired/stimulus";
import Noty from 'noty';
import 'noty/src/noty.scss'
import 'noty/src/themes/bootstrap-v4.scss'

export default class extends Controller {
    static targets = ['field'];

    checkField(event) {
        const element = this.fieldTarget;
        const value = element.value;
        if (value) {
            if (element.title == 'Email') {
                $.ajax({
                    url: `/api/v1/users/check_field?email=${value}`,
                    dataType: 'json',
                    success: function(data) {
                        if (data) {
                            new Noty({
                                text: 'Email already taken',
                                type: 'error',
                                theme: 'bootstrap-v4',
                                progressBar: true,
                                timeout: 3000,
                            }).show();
                        }
                    }
                });
            }
            if (element.title == 'User Name') {
                $.ajax({
                    url: `/api/v1/users/check_field?username=${value}`,
                    dataType: 'json',
                    success: function(data) {
                        if (data) {
                            new Noty({
                                text: 'User Name already taken',
                                type: 'error',
                                theme: 'bootstrap-v4',
                                progressBar: true,
                                timeout: 3000,
                            }).show();
                        }
                    }
                });
            }
        }
    }
}