'use strict';

window.qn = window.qn || {};

window.qn.global = {
  init: function(){
    this.instantiate_handlers();
  },

  instantiate_handlers: function(){
    this.instantiate_modal_handlers();
  },

  instantiate_modal_handlers: function(){
    $("#open-login").leanModal();
  }

}
