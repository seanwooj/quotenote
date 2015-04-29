'use strict';

window.qn = window.qn || {};

window.qn.global = {
  init: function(){
    this.instantiate_handlers();
    this.instantiate_tracking();
  },

  instantiate_handlers: function(){
    this.instantiate_modal_handlers();
  },

  instantiate_modal_handlers: function(){
    $("#open-login").leanModal();
  },

  instantiate_tracking: function(){
    var link_to_image = $("a.link_to_image");
    var add_to_cart = $("a#add-to-cart");
    var checkout = $("a#checkout");
    var order_form = $("#new_order_form");

    analytics.trackLink(link_to_image, 'Downloaded QuoteNote', function(target){
      {url: target.href}
    });

    analytics.trackLink(checkout, 'Started Checkout');

    analytics.trackForm(order_form, 'Filled Out Checkout Form', function(target){
      {name: $(target).find('#order_form_user_name').val()}
    });
  }

}
