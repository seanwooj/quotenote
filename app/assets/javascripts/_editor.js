'use strict';
window.qn = window.qn || {};

window.qn.editor = {
  element: '#quotenote',

  quote_params: {
    font_family: 'cabin_sketch',
    quote_text: ["Your quote here! Enter your", "quote and we'll make something pretty!"],
    quote_author: "",
    background_id: 3,
    overlay: true,
    font_color: 'white',
  },

  init: function(params){
    params = params || {}
    this.quote_params = $.extend(this.quote_params, params)
    this.init_colorpicker();
    this.instantiate_handlers();
    this.init_iframe();
    this.init_font_picker();
    this.init_background_scroll();
  },

  instantiate_handlers: function(){
    this.change_background_on_input();
    this.change_font_on_input();
    this.change_quote_on_input();
    this.add_linebreaks_to_input();
    this.change_quote_author_on_input();
    this.toggle_overlay_on_input();
    this.add_jquery_fileupload();
  },

  init_colorpicker: function(){
    var $input = $("input.colorpicker");
    var that = this;
    $input.spectrum({
      showPaletteOnly: true,
      showPalette:true,
      hideAfterPaletteSelect:true,
      color: 'white',
      palette: [
        ['black', 'white']
      ],
      change: function(color){
        var color = color.toHexString();
        that.change_quote_color(color);
        $input.val(color);
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

  init_iframe: function(){
    $("#iframe").html($('<iframe/>').attr('src', this.generate_querystring()));
    var frame_width = $("#iframe-container").width();
    var frame_height = (frame_width);
    var zoom = frame_width / 1800;
    $('iframe').zoomer({
        zoom: zoom,
        width: frame_width,
        height: frame_height,
        loadingType: 'spinner'
    });
    $("a.link_to_image").attr('href', this.generate_image_querystring());
  },

  grab_all_params_and_generate: function(){
    this.quote_params['font_family'] = $("select.fonts").val();

    if(this.grab_and_arrayify_quote_from_input() != ['']){
      this.quote_params['quote_text'] = this.grab_and_arrayify_quote_from_input();
    }

    if($("#author-box").val() != ''){
      this.quote_params['quote_author'] = $("#author-box").val();
    }

    this.quote_params['font_color'] = $("input.colorpicker").val();
    this.quote_params['overlay'] = $("#overlay").is(":checked");
    console.log(this.quote_params);
    this.change_iframe_src();
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
    this.change_iframe_src();
  },

  change_quote_color: function(color){
    this.quote_params['font_color'] = color;
    this.change_iframe_src();
  },

  valid_hex: function(hex){
    var regex = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/;
    return regex.test(hex);
  },

  cycle_quotes: function(){
    var random_quote = this.quotes[Math.floor(Math.random() * this.quotes.length)];
    this.change_quote(random_quote);
  },

  add_linebreaks_to_input: function(){
    var that = this;
    $("#text-box").on('keyup', function(e){
      var $textarea = $(this);
      var text = $textarea.val();
      var rows = text.split("\n");
      var last_line = rows[rows.length - 1];
      if(last_line.length > 25 && e.keyCode == 32) {
        $textarea.val($textarea.val() + "\n")
      }
    });
  },

  change_quote: function(quote_text) {
    this.quote_params['quote_text'] = quote_text;
    this.change_iframe_src();
  },

  change_quote_on_input: function(){
    var that = this;
    $("#text-box").on("blur", function(e){
      var quote = that.arrayify_text($(e.target).val());
      if (quote == ['']) {
        return false;
      }

      that.change_quote(quote);
    });

    $("#text-box").on("keyup", function(e){
      that.set_timer();
    });
  },

  arrayify_text: function(text){
    return text.split("\n");
  },

  grab_and_arrayify_quote_from_input: function(){
    var arr = this.arrayify_text($("#text-box").val());
    return arr;
  },

  change_quote_author: function(quote_author) {
    this.quote_params['quote_author'] = quote_author;
    this.change_iframe_src();
  },

  change_quote_author_on_input: function(){
    var that = this;
    $("#author-box").on("blur", function(e){
      var author = $(e.target).val();
      that.change_quote_author(author);
    });

    $("#author-box").on("keyup", function(e){
      that.set_timer();
    });
  },

  change_background_id: function(id, repeating){
    this.quote_params['background_id'] = id;
    this.quote_params['repeating'] = repeating;
    this.change_iframe_src();
  },

  change_background_on_input: function(){
    var that = this;
    $(".backgrounds .bg").on("click", function(e){
      var repeating = $(this).data("repeating");
      var id = $(this).data("id");
      that.change_background_id(id, repeating);
      that.change_background_hidden_field_on_input(id);
    });
  },

  change_background_hidden_field_on_input: function(id){
    $("#quote_note_background_id").val(id);
  },

  toggle_overlay_on_input: function(){
    var that = this;
    $("#overlay").on('click', function(e){
      that.toggle_overlay();
    })
  },

  toggle_overlay: function(){
    if(this.quote_params['overlay'] === false){
      this.quote_params['overlay'] = true;
    } else {
      this.quote_params['overlay'] = false;
    }
    this.change_iframe_src();
  },

  change_iframe_src: function(){
    var params = this.generate_querystring();
    $("iframe").zoomer('src', params);
    $("a.link_to_image").attr('href', this.generate_image_querystring());
  },

  init_background_scroll: function(){
    var that = this;
    $(".backgrounds-container .next").on('click', function(){
      that.background_scroll('+');
    });

    $(".backgrounds-container .prev").on('click', function(){
      that.background_scroll('-');
    });
  },

  background_scroll: function(direction){
    var $backgrounds = $(".backgrounds");
    var bg_container_width = $backgrounds.width();
    var scrolled = $backgrounds.scrollLeft();
    $backgrounds.scrollTo({left: direction + '=' + bg_container_width, top: 0}, 800);
  },

  picker_use_font_images: function(font_object){
    var font_name = font_object['text'];
    var element = $("option.font[value=" + font_name + "]")
    var image_url = element.data('image-location');
    return "<img src='" + image_url + "' class='picker_images' />"
  },

  set_timer: function(){
    var that = this;
    window.clearTimeout(this.timeout || null);
    qn.editor.timeout = setTimeout(function(){
      that.grab_all_params_and_generate();
    }, 1000)
  },

  add_jquery_fileupload: function(){
    var that = this;
    $("#new_background").fileupload({
      dataType: 'json',
      done: function (e, data){
        var id = data['result']['id'];
        that.quote_params['background_id'] = id;
        that.change_iframe_src();
        that.change_background_hidden_field_on_input(id);
        $('.fileupload .upload-percentage').html("");
      },
      singleFileUploads: true,
      progressall: function(e,data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('.fileupload .upload-percentage').html(progress + "%");
      }
    });
  }

  // }
};
