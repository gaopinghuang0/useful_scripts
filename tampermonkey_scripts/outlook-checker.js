// ==UserScript==
// @name         outlook-checker
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Check the number of unread email and notify
// @author       Gaoping Huang
// @match        https://outlook.office.com/owa/?realm=purdue.edu*
// @require      https://code.jquery.com/jquery-latest.js
// @grant        none
// ==/UserScript==

(function() {
  'use strict';

  // Your code here...
  $(document).ready(function() {

    repeat_check_unread_email()

  });

  function repeat_check_unread_email() {
    var $inbox = $('span[title="Inbox"]'),
      $unread_div = $inbox.next('div'),
      $count_span = $unread_div.find('span'),
      $title = $('title');

    setInterval(function() {
      var count = parseInt($count_span.text());
      if (count > 0) {
        // alert('New email: ' + count)
        // change title instead of alert
        $title.text('('+count+')');
      } else {
        $title.text('Mail')
      }
    }, 6000);
  }

})();