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
<body>
<div id="map"></div>
<script src="main.js"></script>
 <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6A1Z9yRU1_paAgu2nfhl6l4AKX8EdLtE&callback=initMap" async defer></script>
 <script>
let map;
let globalChangeAble = {
    serverDestination: 'http://192.168.0.103/IS/Google_Map/upload.php',
	infoWindow: {
		last: null,
		isOpen: null
	},
    locations: null,
    myLocation: {
        lat: 22.3193039, 
        lng: 114.169361
    }
}
let lastInfoWindow = null
function awaitPostMessage() {
  let isReactNativePostMessageReady = !!window.originalPostMessage;
  const queue = [];
  let currentPostMessageFn = function store(message) {
    if (queue.length > 100) queue.shift();
    queue.push(message);
  };
  if (!isReactNativePostMessageReady) {
    // const originalPostMessage = window.postMessage;
    Object.defineProperty(window, 'postMessage', {
      configurable: true,
      enumerable: true,
      get() {
        return currentPostMessageFn;
      },
      set(fn) {
        currentPostMessageFn = fn;
        isReactNativePostMessageReady = true;
        setTimeout(sendQueue, 0);
      }
    });
  }

  function sendQueue() {
    while (queue.length > 0) window.postMessage(queue.shift());
  }
}
awaitPostMessage()

function requestShopAddress() {
    fetch(globalChangeAble.serverDestination, {
        method: 'POST',
        header: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then((response) => response.json())
    .then(responseData => {
        globalChangeAble.locations = responseData
    })
    .catch((error) => {
        console.log(error)
    })
    initMap()
}
function initMap() {
    let locations = globalChangeAble.locations
    /*
	let locations = [
        {lat: -31.563910, lng: 147.154312},
        {lat: -33.718234, lng: 150.363181},
        {lat: -33.727111, lng: 150.371124},
        {lat: -33.848588, lng: 151.209834},
        {lat: -33.851702, lng: 151.216968},
        {lat: -34.671264, lng: 150.863657},
        {lat: -35.304724, lng: 148.662905},
        {lat: -36.817685, lng: 175.699196},
        {lat: -36.828611, lng: 175.790222},
        {lat: -37.750000, lng: 145.116667},
        {lat: -37.759859, lng: 145.128708},
        {lat: -37.765015, lng: 145.133858},
        {lat: -37.770104, lng: 145.143299},
        {lat: -37.773700, lng: 145.145187},
        {lat: -37.774785, lng: 145.137978},
        {lat: -37.819616, lng: 144.968119},
        {lat: -38.330766, lng: 144.695692},
        {lat: -39.927193, lng: 175.053218},
        {lat: -41.330162, lng: 174.865694},
        {lat: -42.734358, lng: 147.439506},
        {lat: -42.734358, lng: 147.501315},
        {lat: -42.735258, lng: 147.438000},
        {lat: -43.999792, lng: 170.463352}
    ];*/
	map = new google.maps.Map(document.querySelector('#map'), {
		center: {
			lat: globalChangeAble.myLocation.lat, 
			lng: globalChangeAble.myLocation.lng
		},
		zoom: 10,
		scaleControl: false,
		fullscreenControl: false,
		mapTypeControl: false,
		streetViewControl: false,
		rotateControl: false
	});
	var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	let infowindows = locations.map(function(location, i) {
		return new google.maps.InfoWindow({
			content: '3322222'
		})
	})
	var markers = locations.map(function(location, i) {
        return new google.maps.Marker({
        	position: location,
            label: labels[i % labels.length],
            map: map,
            draggable: false,
            animation: google.maps.Animation.DROP,
            title: '312'
        });
    });
	markers.map(function(marker, i) {
		google.maps.event.addListener(marker, 'click', () => {
			const lastInfoWindow = globalChangeAble.infoWindow.last
			const isOpen = globalChangeAble.infoWindow.isOpen
			if (lastInfoWindow !== null) {
				if (lastInfoWindow == i) {
					if (isOpen) {
						infowindows[i].close()
						globalChangeAble.infoWindow.isOpen = false
					} else{
						infowindows[i].open(map, marker);
						globalChangeAble.infoWindow.isOpen = true
					}
				} else {
					infowindows[lastInfoWindow].close()
					infowindows[i].open(map, marker)
					globalChangeAble.infoWindow.isOpen = true
				}
			} else {
				infowindows[i].open(map, marker)
				globalChangeAble.infoWindow.isOpen = true
			}
    		globalChangeAble.infoWindow.last = i
    		//window.ReactNativeWebView.postMessage('asdf')
    		setTimeout(function() {
    			window.ReactNativeWebView.postMessage('hello!!!')
    		}, 100)
    	})
    })
}
function queryShopsWithLocation($position) {

}
function returnMerchantChode(marker, info) {
	/*
	console.log(marker.title)
	console.log(info.content)*/
	//window.postMessage('asd')
	//console.log(window.postMessage('byebye111'))
}
function moveToLocation() {
    let center = new google.maps.LatLng(globalChangeAble.myLocation.lat, globalChangeAble.myLocation.lng);
    map.panTo(center);
}
document.addEventListener("message", function(data) {
    let request = JSON.parse(data.data);
    let requestType = request.requestType;
    let details = request.details;
    switch (requestType) {
        case 'myLocation':
            const location = {
                lat: details.location.coords.latitude,
                lng: details.location.coords.longitude,
            };
            globalChangeAble.myLocation.lat = location.lat
            globalChangeAble.myLocation.lng = location.lng
            moveToLocation();
        break;
    }
    //alert(JSON.stringify(details.location));
})
/* zooming
1: World
5: Landmass/continent
10: City
15: Streets
20: Buildings

*/
 </script>
</body>
</html>
