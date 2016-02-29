// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .
//= require fancybox

$(document).ready(function() {
  $("a.fancybox").fancybox({
    'width': 700,
    'height': 400,
    'margin': 20,
    'padding': 10,
    'topRatio': 0.1,
    'scrolling': 'auto',
    'autoSize': false
    });
});

$(function(){
  window.setTimeout(function(){
    $('.alert-info').fadeOut(500);
  }, 3000);
});

$(function() {

    //クリックしたときのファンクションをまとめて指定

    $('.tab li').click(function() {

 
        //.index()を使いクリックされたタブが何番目かを調べ、
        //indexという変数に代入します。
        var index = $('.tab li').index(this);
 
        //コンテンツを一度すべて非表示にし、

        $('.content li').css('display','none');
 
        //クリックされたタブと同じ順番のコンテンツを表示します。
        $('.content li').eq(index).css('display','block');

        //一度タブについているクラスselectを消し、
        $('.tab li').removeClass('select');
 
        //クリックされたタブのみにクラスselectをつけます。
   $(this).addClass('select')

    });
});
