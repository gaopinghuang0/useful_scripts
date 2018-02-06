// ==UserScript==
// @name         Qidian Filter
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Fade out some types of novels on qidian.
// @author       Gaoping Huang
// @match        https://*.qidian.com/*
// @require      https://code.jquery.com/jquery-latest.js
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    var banNovelTypes = ['都市', '历史'];

    $(document).ready(function() {
        hideNovelByType();
    });

    function hideNovelByType() {
        $('ul.all-img-list li').each(function() {
            var type = $(this).find('a[data-eid="qd_B60"]').text();
            if (banNovelTypes.indexOf(type) !== -1) {
                $(this).css('opacity', 0.1);
            }
        });
    }
})();
