'use strict';
window.qn = window.qn || {};

window.qn.generator = {
  element: '#quotenote',

  init: function(){
    var $ele = $(this.element);
    this.text_adjustments($ele);
  },

  text_adjustments: function($ele){
    var $quote = $ele.find('.quote-text');
    var $author = $ele.find('.author-text');
    var $container = $ele.find('.quote');
    var $lines = $ele.find('.quote-text-line');
    var $background = $ele;

    var $longest_line = this.get_longest_line($lines);

    var line_width = $longest_line.outerWidth();
    var container_width = $container.width();
    var font_size = parseInt( $quote.css("font-size") );

    while(container_width > (line_width) ) {
      line_width = $longest_line.outerWidth();
      font_size = font_size + 0.5;
      $quote.css({"font-size": font_size + "px"});
    }

    while(container_width < (line_width) ) {
      line_width = $longest_line.outerWidth();
      font_size = font_size - 0.5;
      $quote.css({"font-size": font_size + "px"});
    }

    var author_font_size = font_size / 1.5;
    $author.css({"font-size": author_font_size + "px"});

    this.center_content_vertically($container, $background);
  },

  get_longest_line: function($lines) {
    var longest_width = 0;
    var $longest_line;

    // Pick the longest line by looping through all the elements.
    $lines.each(function(index){
      var current_width = $(this).width();
      if( current_width > longest_width ) {
        longest_width = current_width;
        $longest_line = $(this);
      }
    });

    return $longest_line;
  },

  center_content_vertically: function($container, $background){
    var background_height = $background.height();
    var container_height = $container.outerHeight();
    var top_offset = (background_height - container_height) / 2;

    $container.css({"top": top_offset + "px"});
  }

};
