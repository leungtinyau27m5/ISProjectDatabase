<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="initial-scale=1.0" />
	<meta charset="utf-8" />
	<style>
		#map {
			height: 100%;
			width: 100%;
		}
		html, body {
			height: 100%;
			margin: 0;
			padding: 0;
		}
	</style>
</head>
<body onload="initialize()">
<!-- <div id="map"></div> -->
<div id="map" style="width: 320px; height: 480px;"></div>
<div>
    <input id="address" type="textbox" value="Sydney, NSW">
    <input type="button" value="Encode" onclick="codeAddress()">
    <form action="upload.php" method="POST">
    	<input id="return-text" name="return-text" style="width: 320px; height: 200px"/>
    	<input type="submit" value="Submit">
    </form>
  </div>
 	
 </div>
<script src="main.js"></script>
 <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6A1Z9yRU1_paAgu2nfhl6l4AKX8EdLtE&callback=initialize" async defer></script>
 <script>
 let geocoder;
 let map;
function initialize() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(-34.397, 150.644);
    var mapOptions = {
      zoom: 8,
      center: latlng
    }
    map = new google.maps.Map(document.getElementById('map'), mapOptions);
  }
  function codeAddress() {
    var address = document.getElementById('address').value;
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == 'OK') {
      	console.log(results)
      	let node = document.querySelector('#return-text');
      	node.value = JSON.stringify(results);
      	//console.log(node.value);
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }
 </script>