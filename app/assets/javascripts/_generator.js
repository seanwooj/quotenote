'use strict';
window.qn = window.qn || {};

window.qn.generator = {
  element: '#quotenote',

  init: function(){
    var $ele = $(this.element);
    this.resize_text($ele);
  },

  resize_text: function($ele){
    var $quote = $ele.find('.quote-text');
    var $author = $ele.find('.author-text');
    var $container = $ele.find('.quote');
    var $background = $ele;
    var content_height = $container.outerHeight();
    var background_height = $background.height();
    var font_size = parseInt($quote.css("font-size"));

    while(background_height > (content_height) ) {
      content_height = $container.outerHeight();
      font_size = font_size + 0.5;
      $quote.css({"font-size": font_size + "px"});
    }

    while(background_height < (content_height) ) {
      content_height = $container.outerHeight();
      font_size = font_size - 0.5;
      $quote.css({"font-size": font_size + "px"});
    }

    var author_font_size = font_size / 1.5;

    $author.css({"font-size": author_font_size + "px"});
  }

};
