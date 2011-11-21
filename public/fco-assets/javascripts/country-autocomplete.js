if(!Object.keys) {
  Object.keys = function(o) {
    if (o !== Object(o)) {
      throw new TypeError('Object.keys called on non-object');
    }
      
    var ret = [], p;
    for(p in o) if (Object.prototype.hasOwnProperty.call(o,p)) ret.push(p);
    return ret;
  }
}

$(function() {
  var available_countries = {};
  $('#travelling-to li a').each(function () {
    var this_country = $(this);
    available_countries[this_country.text()] = this_country.attr('href');
  });

  $('#travelling-to').before('<input id="country">').hide();
  $('#country').autocomplete({
    minLength: 0,
    source: Object.keys(available_countries),
    select: function(event, ui) {
      window.location = available_countries[ui.item.value];
      return false;
		}
  });
})