$(document).ready(function(){
  add_address = function(addr){
    var html = "";
    if(addr!=undefined){
      html += addr['firstname'] + " " + addr['lastname'] + ", ";
      html += addr['address1'] + ", " + addr['address2'] + ", ";
      html += addr['city'] + ", ";

      if(addr['state_id']!=null){
        html += addr['state']['name'] + ", ";
      }else{
        html += addr['state_name'] + ", ";
      }

      html += addr['country']['name'];
    }
    return html;
  }

  format_user_autocomplete = function(data){
    var html = "<h4>" + data['email'] +"</h4>";
    html += "<span><strong>Billing:</strong> ";
    html += add_address(data['bill_address']);
    html += "</span>";

    html += "<span><strong>Shipping:</strong> ";
    html += add_address(data['ship_address']);
    html += "</span>";

    return html
  }

  prep_user_autocomplete_data = function(data){
    return $.map(eval(data), function(row) {
      return {
          data: row['user'],
          value: row['user']['email'],
          result: row['user']['email']
      }
    });
  }


  $('input#order_use_billing').click(function() {
    show_billing(!$(this).is(':checked'));
  });

  $('#guest_checkout_true').change(function() {
    $('#customer_search').val("");
    $('#user_id').val("");
    $('#checkout_email').val("");
    $('#guest_checkout_false').prop("disabled", true);

    $('#order_bill_address_attributes_firstname').val("");
    $('#order_bill_address_attributes_lastname').val("");
    $('#order_bill_address_attributes_address1').val("");
    $('#order_bill_address_attributes_address2').val("");
    $('#order_bill_address_attributes_city').val("");
    $('#order_bill_address_attributes_zipcode').val("");
    $('#order_bill_address_attributes_state_id').val("");
    $('#order_bill_address_attributes_country_id').val("");
    $('#order_bill_address_attributes_phone').val("");

    $('#order_ship_address_attributes_firstname').val("");
    $('#order_ship_address_attributes_lastname').val("");
    $('#order_ship_address_attributes_address1').val("");
    $('#order_ship_address_attributes_address2').val("");
    $('#order_ship_address_attributes_city').val("");
    $('#order_ship_address_attributes_zipcode').val("");
    $('#order_ship_address_attributes_state_id').val("");
    $('#order_ship_address_attributes_country_id').val("");
    $('#order_ship_address_attributes_phone').val("");
  });

  var show_billing = function(show) {
    if(show) {
      $('#shipping').show();
      $('#shipping input').prop("disabled", false);
      $('#shipping select').prop("disabled", false);
    } else {
      $('#shipping').hide();
      $('#shipping input').prop("disabled", true);
      $('#shipping select').prop("disabled", true);
    }
  }

});


