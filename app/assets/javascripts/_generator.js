'use strict';
window.qn = window.qn || {};

window.qn.generator = {
  element: '#quotenote',
  quotes: [
    "Passion and Gradualness",
    "All that we are is the result of what we have thought",
    "Become who you are by learning who you are",
    "Things ain’t what they use to be and probably never was",
    "It takes as much energy to wish as it does to plan.",
    "I can accept failure, everyone fails at something. But I can’t accept not trying"
  ],

  fonts: [
    'Pacifico', 'Roboto Condensed', 'Raleway', 'Montserrat', 'Cabin'
  ],

  init: function(){
    var $ele = $(this.element);
    this.resize_text($ele);
    // this.init_colorpicker();
  },

  init_colorpicker: function(){
    var $input = $("input.minicolors");
    var that = this;
    $input.minicolors({
        change: function(hex, opacity){
          console.log(hex);
          that.change_quote_color(hex);
        }
    });
  },

  change_quote_color: function(color){
    $(".quote-text").css({color: color});
  },

  resize_text: function($ele){
    var $quote = $ele.find('.quote-text');
    var $container = $ele.find('.quote');
    var $background = $ele;
    var content_height = $container.outerHeight();
    var background_height = $background.height();
    var font_size = parseInt($quote.css("font-size"));

    // $ele.height(background_height);

    while(background_height > (content_height) ) {
      content_height = $container.outerHeight();
      font_size = font_size + 0.5;
      $quote.css({"font-size": font_size + "px"});
    }

    while(background_height < (content_height) ) {
      console.log(background_height + 'qh');
      console.log(content_height + 'ch');
      content_height = $container.outerHeight();
      font_size = font_size - 0.5;
      $quote.css({"font-size": font_size + "px"});
    }
  },

  change_quote: function(quote_text) {
    var $quote = $('.quote-text');
    $quote.text(quote_text);
  },

  change_quote_on_input: function(){
    var $ele = $(this.element);
    var quote = window.prompt("what quote?");
    this.change_quote(quote);
    this.resize_text($ele);
  },

  toggle_background: function(){ // This should be a temporary method.
    var $ele = $("#quotenote");
    $ele.css({"background-image": "url('assets/img/backgrounds/nature_03.jpg')"});
    $ele.toggleClass("cover-background");

  }
};
