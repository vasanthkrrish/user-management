import { Controller } from "@hotwired/stimulus";
import Noty from 'noty';
import 'noty/src/noty.scss';
import 'noty/src/themes/bootstrap-v4.scss';

export default class extends Controller {
    static targets = ['type', 'message'];

    connect () {
        new Noty({
            text: this.messageTarget.value,
            type: this.getNotificationType(),
            theme: 'bootstrap-v4',
            progressBar: true,
            timeout: 5000,
        }).show()
    }

    getNotificationType () {
        switch (this.typeTarget.value) {
            case 'notice':
                return 'info'
            case 'success':
                return 'success'
            case 'error':
                return 'error'
            case 'alert':
                return 'warning'
            default:
                return 'info'
        }
    }
}
