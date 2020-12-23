
window.addEventListener("turbolinks:load", () => {
  let initMap = () => {
    let lat = document.getElementById('lat')?.value;
    let lon = document.getElementById('lon')?.value;

    if (lat && lon) {
      let mymap = L.map('map').setView([lat, lon], 13);

      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
        maxZoom: 18
      }).addTo(mymap)

      marker = L.marker([lat, lon]).addTo(mymap)
    }
  }

  initMap();
});
