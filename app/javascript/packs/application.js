// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../js/bootstrap_js_files.js'
import "@fortawesome/fontawesome-free/css/all"
import "jquery"
import '../js/controllers'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
global.Rails = Rails;

$(document).ready(function () {
    $(".alert-dismissible").fadeTo(2000, 500).slideUp(500, function(){
        $(".alert-dismissible").alert('close');
    });
});