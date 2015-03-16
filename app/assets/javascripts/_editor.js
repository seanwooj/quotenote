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
    font_family: 'cabin_sketch',
    quote_text: "Your quote here! Enter your quote and we'll make something pretty!",
    quote_author: "You!",
    background_id: 3,
    overlay: false
  },

  init: function(){
    this.init_colorpicker();
    this.instantiate_handlers();
    this.init_iframe();
    this.init_font_picker();
  },

  instantiate_handlers: function(){
    this.change_background_on_input();
    this.change_font_on_input();
    this.change_quote_on_input();
    this.toggle_overlay_on_input();
  },

  init_colorpicker: function(){
    var $input = $("input.minicolors");
    var that = this;
    $input.spectrum({
      showPaletteOnly: true,
      showPalette:true,
      hideAfterPaletteSelect:true,
      color: 'black',
      palette: [
        ['black', 'white', '#3b5998']
      ],
      change: function(color){
        var color = color.toHexString();
        that.change_quote_color(color);
      }
    });
  },

  init_font_picker: function(){
    var that = this;

    $(".fonts").select2({
      minimumResultsForSearch: Infinity,
      formatResult: this.picker_use_font_images,
      formatSelection: this.picker_use_font_images,
      dropdownCssClass: 'font-picker',
      containerCssClass: 'font-picker-selection'
    })

    $(".fonts").on("select2-selecting", function(e){
      that.change_font(e.val);
    });
  },

  picker_use_font_images: function(font_object){
    var font_name = font_object['text'];
    var element = $("option.font[value=" + font_name + "]")
    var image_url = element.data('image-location');
    return "<img src='" + image_url + "' class='picker_images' />"
  },

  init_iframe: function(){
    $("#iframe").html($('<iframe/>').attr('src', this.generate_querystring()));
    var frame_width = $("#iframe-container").width();
    var frame_height = (frame_width * 4) / 6;
    var zoom = frame_width / 1800;
    $('iframe').zoomer({
        zoom: zoom,
        width: frame_width,
        height: frame_height,
        loadingType: 'spinner'
    });
    $("a.link_to_image").attr('href', this.generate_image_querystring());
  },

  generate_querystring: function(){
    return "/generator?" + $.param(this.quote_params);
  },

  generate_image_querystring: function(){
    var image_params = {}
    $.extend(image_params, this.quote_params);
    image_params['full_size'] = true;
    return "/generator.jpg?" + $.param(image_params);
  },

  change_font_on_input: function(){
    var that = this;
    $(".fonts .font").on("click", function(e){
      var font_name = $(this).data('font-name');
      that.change_font(font_name);
    });
  },

  change_font: function(font_name){
    this.quote_params['font_family'] = font_name;
    var params = this.generate_querystring();
    this.change_iframe_src(params);
  },

  change_quote_color: function(color){
    this.quote_params['font_color'] = color;
    var params = this.generate_querystring();
    this.change_iframe_src(params);
  },

  valid_hex: function(hex){
    var regex = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/;
    return regex.test(hex);
  },

  cycle_quotes: function(){
    var random_quote = this.quotes[Math.floor(Math.random() * this.quotes.length)];
    this.change_quote(random_quote);
  },

  change_quote: function(quote_text) {
    this.quote_params['quote_text'] = quote_text;
    var params = this.generate_querystring();
    this.change_iframe_src(params);
  },

  change_quote_on_input: function(){
    var that = this;
    $("#text-box").on("blur", function(e){
      var quote = $(e.target).val();
      if (quote == '') {
        return false;
      }

      that.change_quote(quote);
    });
  },

  change_background_id: function(id, repeating){
    this.quote_params['background_id'] = id;
    this.quote_params['repeating'] = repeating;
    var params = this.generate_querystring();
    this.change_iframe_src(params);
  },

  change_background_on_input: function(){
    var that = this;
    $(".backgrounds .bg").on("click", function(e){
      var repeating = $(this).data("repeating");
      var id = $(this).data("id");
      that.change_background_id(id, repeating);
    });
  },

  toggle_overlay_on_input: function(){
    var that = this;
    $("#high_contrast").on('click', function(e){
      that.toggle_overlay()
    })
  },

  toggle_overlay: function(){
    if(this.quote_params['overlay'] === false){
      this.quote_params['overlay'] = true;
    } else {
      this.quote_params['overlay'] = false;
    }
    var params = this.generate_querystring();
    this.change_iframe_src(params);
  },

  change_iframe_src: function(params){
    $("iframe").zoomer('src', params);
    $("a.link_to_image").attr('href', this.generate_image_querystring());
  }

  // }
};
