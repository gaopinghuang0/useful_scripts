// ==UserScript==
// @name         Qidian Filter
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  Fade out novels on qidian by specific types or manual ban.
// @author       Gaoping Huang
// @match        https://*.qidian.com/*
// @require      https://code.jquery.com/jquery-latest.js
// @grant        GM.getValue
// @grant        GM.setValue
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    var banNovelTypes = ['都市', '历史'];

    $(document).ready(function() {
        hideNovelByType();
        hideAllBannedNovel();
        showBanButtons();
        handleBanButtons();
    });

    function hideNovelByType() {
        $('ul.all-img-list li').each(function() {
            var book_type = $(this).find('a[data-eid="qd_B60"]').text();
            var self = $(this);
            if (banNovelTypes.indexOf(book_type) !== -1) {
                self.addClass('banned-by-type').css('opacity', 0.1);
            }
        });
    }
    function showBanButtons() {
        $('ul.all-img-list li').each(function() {
            var book_id = $(this).find('a[data-eid="qd_B58"]').attr('data-bid');
            if (book_id) {
                var $btn = $('<button class="ban-novel-btn">').attr('data-bid', book_id).html('&#9033;');
                $btn.css({position: "absolute", top: 0, right: 5, cursor: 'pointer'});
                $(this).css('position', 'relative').append($btn);
            }
        });
    }
    function handleBanButtons() {
        $('.ban-novel-btn').on('click', function() {
            var book_id = $(this).attr('data-bid');
            banNovelById(book_id);
        });
    }
    function banNovelById(book_id) {
        // console.log(book_id);
        if (typeof book_id === undefined) return;

        GM.getValue('banned_books').then(function(banned_books) {
            if (!banned_books) {
                banned_books = {};
                banned_books[book_id] = true;
            }
            else if (!(book_id in banned_books)) {
                banned_books[book_id] = true;
            } else {
                delete banned_books[book_id];
            }
            GM.setValue('banned_books', banned_books).then(function() {
                hideAllBannedNovel();
            });
        });
    }
    function hideAllBannedNovel() {
        GM.getValue('banned_books').then(function(banned_books) {
            console.log('all banned books:', banned_books);
            $('ul.all-img-list li').each(function() {
                var book_id = $(this).find('a[data-eid="qd_B58"]').attr('data-bid');
                if (book_id in banned_books) {    // ban
                    $(this).css('opacity', 0.1);
                    $(this).find('.ban-novel-btn').css('background-color', 'red');
                }
                else if (!($(this).hasClass('banned-by-type'))) {   // undo ban if not banned-by-type
                    $(this).css('opacity', 1);
                    $(this).find('.ban-novel-btn').css('background-color', 'white');
                }
            });
        });
    }

})();