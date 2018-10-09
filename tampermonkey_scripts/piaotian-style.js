// ==UserScript==
// @name         PiaoTian Style
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Change style of piantian.com
// @author       You
// @match        https://www.piaotian.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    var body = document.querySelector('body');
    body.style.fontFamily = 'Microsoft Yahei';
})();