$(document).ready(function() {
  if ($('section.fco-country').length > 0) {
    var countryInfoElement = $('div.country-info');
    var boundingBox = countryInfoElement.data('bounding-box');

    if (boundingBox) {
      $('.country-info').prepend($('<div id="country-map" class="country-map" />'));

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

      var boundingBoxArray = boundingBox.split(',');

      var west = parseFloat(boundingBoxArray[0]),
          south = parseFloat(boundingBoxArray[1]),
          east = parseFloat(boundingBoxArray[2]),
          north = parseFloat(boundingBoxArray[3]);

      var southWest = new L.LatLng(south, west);
          northEast = new L.LatLng(north, east);

      var bounds = new L.LatLngBounds(southWest, northEast);

      map.fitBounds(bounds);

      if (map.getZoom() > 5) {
        map.setZoom(5);
      }

      var countryCode = countryInfoElement.data('iso-code');
      var borderJsonUrl = "/fco-assets/borders/"+countryCode+".json";

      $.ajax(borderJsonUrl).success(function(data) {
        var geojson = new L.GeoJSON();

        geojson.on("featureparse", function(e) {
          e.layer.setStyle({
            color: '#ffbd30',
            fillColor: '#ffbd30',
            weight: 1,
            fillOpacity: 1.0
          });
        });

        geojson.addGeoJSON(data);

        map.addLayer(geojson);
      });
    }
  }
});