$(document).ready(function() {
  if ($('section.fco-country').length > 0) {
    var countryInfoElement = $('div.country-info');
    var boundingBox = countryInfoElement.data('bounding-box');

    if (boundingBox) {
      $('.country-info').prepend($('<div id="country-map" class="country-map" />'));

      var boundingBoxArray = boundingBox.split(',');

      var cloudmadeUrl = 'http://{s}.tile.cloudmade.com/bcad1b026ce64e2ab602c9fb3ff38c88/997/256/{z}/{x}/{y}.png',
          cloudmadeAttribution = 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2011 CloudMade',
          cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 18});

      var map = new L.Map('country-map', {
        attributionControl: false,
        zoomControl: false,
        dragging: false,
        touchZoom: false,
        scrollWheelZoom: false,
        doubleClickZoom: false
      });
      map.addLayer(cloudmade);

      var west = parseFloat(boundingBoxArray[0]),
          south = parseFloat(boundingBoxArray[1]),
          east = parseFloat(boundingBoxArray[2]),
          north = parseFloat(boundingBoxArray[3]);

      var southWest = new L.LatLng(south, west);
          northEast = new L.LatLng(north, east);

      var bounds = new L.LatLngBounds(southWest, northEast);

      map.fitBounds(bounds);
    }
  }
});