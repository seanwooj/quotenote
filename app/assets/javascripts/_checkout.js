'use strict';
window.qn = window.qn || {};

window.qn.checkout = {
  validations: {
    '#order_form_user_first_name': 'validateName',
    '#order_form_user_last_name': 'validateName',
    '#order_form_user_address': 'validateAddress',
    '#order_form_user_postal_code': 'validatePostCode',
    '#order_form_user_city': 'validateCity',
    '#order_form_user_phone': 'validatePhone'
  },

  init: function () {
    this.instantiateHandlers();
  },

  instantiateHandlers: function () {
    this.formHandler();
    this.inputHandler();
  },

  formHandler: function () {
    $("#new_order_form").on('invalid', function (event){
      debugger;
      $(".validate").addClass('dirty').removeClass('pristine');

    });
  },

  inputHandler: function () {
    var that = this;
    $(".validate").on('keyup', function (event){
      that.validateElement(this);
    });
  },

  validateElement: function (element) {
    var $ele = $(element);
    if ($ele.hasClass('pristine')) {
      $ele.removeClass('pristine').addClass('dirty');
    }

    var validationFunctionName = this.validations['#' + $ele.attr("id")];

    // If there is a validation function AND the validation fails
    // if ( validationFunctionName && !this[validationFunctionName]($ele) ) {
    //   $ele.removeClass('valid');
    //   $ele.addClass('error');
    // } else {
    //   $ele.removeClass('error');
    //   $ele.addClass('valid');
    // }
  },

  // VALIDATION FUNCTIONS
  // From the validations object.
  validateName: function ($ele) {
    return /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/.test( $ele.val() );
  },

  getElementNames: function () {
    var elementArray = [];
    $(".validate").each(function (ele){
      elementArray.push( this.name.replace(/\[/g, ' ').replace(/\]/g, '').split(' ') );
    });

    return elementArray;
  }

};
