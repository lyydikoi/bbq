import flatpickr from 'flatpickr'

const initDatePicker = () => {
  flatpickr("[data-behavior='flatpickr']", {
    altInput: true,
    altFormat: "F j, Y",
    enableTime: true,
    dateFormat: "Y-m-d H:i"
  });
}
  
export default initDatePicker;
