import initMap from '../js/init_map'
import initDatePicker from '../js/init_date_picker'
import 'bootstrap'
import 'ekko-lightbox/dist/ekko-lightbox'
import "@fortawesome/fontawesome-free/js/all";

window.addEventListener("turbolinks:load", () => {
  initMap();
  initDatePicker();
})

$(document).on('click', '[data-toggle="lightbox"]', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});
