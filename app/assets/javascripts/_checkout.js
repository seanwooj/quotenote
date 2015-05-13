'use strict';
window.qn = window.qn || {};

window.qn.checkout = {
  // This is primarily used for validations.
  // Most validations are handled by HTML5 elements
  // so this only covers a few special cases which
  // are typically not handled by the HTML5 validation API.
  validations: {
    '#order_form_user_state': {fn: 'stateInputValidation', msg: 'Please select state!'}
  },

  init: function () {
    this.instantiateHandlers();
  },

  instantiateHandlers: function () {
    this.formHandler();
    this.inputHandler();
    // This custom handler should be here
    // until we add more custom handlers,
    // after which we should pull it into
    // other methods.
    this.countryStateHandler();
  },

  formHandler: function () {
    var that = this;
    // TODO - find a way less hacky way to prevent form submission
    // instead of binding to the submit input

    // I would way rather prefer to bind to the form submit
    // but the braintree drop in submit handler beats my custom handler every time.

    $("input[type=submit]").on('click', function (event){
      $(".validate").addClass('dirty').removeClass('pristine');
      $(".validate").each(function () {
        that.validateElement(this);
      });
      if ( $("#new_order_form")[0].checkValidity() === false ){
        event.preventDefault();
      }
    });
  },

  inputHandler: function () {
    var that = this;
    $(".validate").on('change blur keyup', function (event){
      that.validateElement(this);
    });
  },

  countryStateHandler: function () {
    var that = this;
    $("#order_form_user_country").on('change', function (event) {
      that.validateElement("#order_form_user_state");
    });
  },

  // This is our entry point into all validations.
  // This adds the dirty class to input elements
  // as well as running custom validation elements
  // if any exist.
  // Takes a string jQuery selector string
  // eg: '#idOfElement'
  validateElement: function (element) {
    var $ele = $(element);
    if ($ele.hasClass('pristine')) {
      $ele.removeClass('pristine').addClass('dirty');
    };

    var validationObject = this.validations['#' + $ele.attr("id")];

    // If there is a validation function AND the validation fails
    if ( validationObject && !this[validationObject['fn']]($ele) ) {
      $ele[0].setCustomValidity(validationObject['msg']);
    } else {
      $ele[0].setCustomValidity('');
    }
  },

  // CUSTOM VALIDATOR FUNCTIONS
  // DEFINED in validations obj
  stateInputValidation: function ($ele) {
    // This isn't the best way to do this. I want to be able to pass in a value
    if ( $("#order_form_user_country").val() == 'US' ) {
      if ( $ele.val() ) {
        return true;
      } else {
        return false;
      }
    } else {
      // if the country isn't the US, do the opposite
      if ( $ele.val() ) {
        return false;
      } else {
        return true;
      }
    };
  },


};
