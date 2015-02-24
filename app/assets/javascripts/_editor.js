'use strict';
window.qn = window.qn || {};

window.qn.editor = {
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

  quote_params: {
    font_family: 'Laila',
    quote_text: "Your quote here! Enter your quote and we'll make something pretty!",
    quote_author: "You!"
  },

  init: function(){
    var $ele = $(this.element);
    this.init_colorpicker();
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

  generate_querystring: function(){
    return "/generator?" + $.param(this.quote_params);
  },

  change_font: function(){
    var font_family = window.prompt('which font?');
    this.quote_params['font_family'] = font_family;
    var params = this.generate_querystring();
    $("iframe").attr('src', params); // DRY THIS
  },

  // change_quote_color: function(color){
  //   $(".quote-text").css({color: color});
  // },

  cycle_quotes: function(){
    var random_quote = this.quotes[Math.floor(Math.random() * this.quotes.length)];
    this.change_quote(random_quote);
  },

  change_quote: function(quote_text) {
    this.quote_params['quote_text'] = quote_text;
    var params = this.generate_querystring();
    $("iframe").attr('src', params); // DRY THIS
  },

  change_quote_on_input: function(){
    var $ele = $(this.element);
    var quote = window.prompt("what quote?");
    this.change_quote(quote);
  },

  // toggle_background: function(){ // This should be a temporary method.
  //   var $ele = $("#quotenote");
  //   $ele.css({"background-image": "url('assets/img/backgrounds/nature_03.jpg')"});
  //   $ele.toggleClass("cover-background");

  // }
};
