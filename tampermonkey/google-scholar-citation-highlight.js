// ==UserScript==
// @name         Highlight Paper by Citation
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Highlight the papers with many citations.
// @author       Gaoping Huang
// @match        https://scholar.google.com/scholar?*
// @grant        none
// @require      https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.18.2/babel.js
// @require      https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.16.0/polyfill.js
// @require      https://code.jquery.com/jquery-latest.js
// ==/UserScript==



// Steps to use ES6 template: add new script -> "Developer" tab -> "Templates" -> ES6
// As of 10/10/2019, the jshint error does not matter.

var inline_src = (<><![CDATA[

    // Your code here...
    const threshold_number_to_highlight = 20;

    $(document).ready(() => {
        highlightPaperAboveThreshold();
    });
    function highlightPaperAboveThreshold() {
        $("div.gs_r").each(function() {
            // Locate the link.
            // The citation link is right next to the cite button.
            const element = $(this);
            const citeButton = element.find('.gs_or_cit');
            const citationElement = citeButton.next('a');
            const text = citationElement.text();

            if (!text.startsWith('Cited by'))
                return;

            const number = parseInt(text);
            if (number < threshold_number_to_highlight)
                return;

            citationElement.css('background-color', 'yellow');
        });
    }

]]></>).toString();
var c = Babel.transform(inline_src, { presets: [ "es2015", "es2016" ] });
eval(c.code);