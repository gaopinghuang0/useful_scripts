// ==UserScript==
// @name         Qidian Highlight
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Highlight the comments that have more than 2 replies!
// @author       Gaoping Huang
// @match        https://*.qidian.com/*
// @require      https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.18.2/babel.js
// @require      https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.16.0/polyfill.js
// @require      https://code.jquery.com/jquery-latest.js
// @grant        none

// Credit to the tutorial:
// https://hibbard.eu/tampermonkey-tutorial/
// ==/UserScript==


/* jshint ignore:start */
var inline_src = (<><![CDATA[
/* jshint ignore:end */
    /* jshint esnext: false */
    /* jshint esversion: 6 */

    // Your code here...
    $(document).ready(() => {
        highlightReply();
        foldSpamComment();
    });
    function highlightReply() {
        let infos = $('.post-info');
        let reply_wrappers = infos.find('.mr20');
        reply_wrappers.each(function() {
            let $span = $(this).find('span');
            // let found = text.match(/(\d+)条回复/);
            let num = parseInt($span.text());
            if (num >= 2) {
                $span.css('background-color', 'yellow');
            }
        });
    }
    function foldSpamComment() {
        $('.post-wrap, .comment-wrap').each(function() {
            let text = $(this).find('.post-body').text();
            if (text.indexOf('签到') !== -1) {
                // hide
                $(this).hide();
            }
        });
    }

/* jshint ignore:start */
]]></>).toString();
var c = Babel.transform(inline_src, { presets: [ "es2015", "es2016" ] });
eval(c.code);
/* jshint ignore:end */