$(document).ready(function() {
  var countryInfoElement = $('div.country-info');
  var countryCode = countryInfoElement.data('iso-code');
  var borderJsonUrl = "/fco-assets/borders/"+countryCode+".json";

  $.ajax(borderJsonUrl).success(function(data) {
    var countryName = countryInfoElement.data('country-name');

    var countryInfo = $('.country-info');
    $('<div id="country-map" class="country-map" />').appendTo(countryInfo);
    $('<p class="map-caption" />').text("Map of "+countryName).appendTo(countryInfo);

    var coastlinesUrl = 'http://tiles.alphagov.co.uk/coastlines/{z}/{x}/{y}.png',
        coastlines = new L.TileLayer(coastlinesUrl, {maxZoom: 8});

    var map = new L.Map('country-map', {
      attributionControl: false,
      zoomControl: false,
      dragging: false,
      touchZoom: false,
      scrollWheelZoom: false,
      doubleClickZoom: false
    });

    map.addLayer(coastlines);

    var geojson = new L.GeoJSON();

    geojson.on("featureparse", function(e) {
      e.layer.setStyle({
        color: '#ffbd30',
        fillColor: '#ffbd30',
        weight: 1,
        fillOpacity: 1.0
      });
    });

    var extent = geoff.extent().encloseGeometry(data.geometry);
    var southWest = new L.LatLng(extent.min.lat, extent.min.lon);
    var northEast = new L.LatLng(extent.max.lat, extent.max.lon);
    var bounds = new L.LatLngBounds(southWest, northEast);

    geojson.addGeoJSON(data);
    map.addLayer(geojson);
    map.fitBounds(bounds);

    if (map.getZoom() > 5) {
      map.setZoom(5);
    }
  });
});