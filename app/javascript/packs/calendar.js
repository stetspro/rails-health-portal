import jsCalendar from './jsCalendar.js';

// Create a new calendar
var myCalendar = jsCalendar.new("#my-calendar");

// Get the current date
var currentDate = new Date();

// Get the date 6 months from now
var futureDate = new Date(
    currentDate.getFullYear(),
    currentDate.getMonth() + 6,
    currentDate.getDate()
);

// Set min to the current date
myCalendar.min("now");

// Set max to the date 6 months from now
myCalendar.max(futureDate);

// Get appointment date input field
var appointmentDateInput = document.getElementById("appointment-date");

var selectedElement = null;
// Initialize selectedDate variable
let selectedDate = null;

myCalendar.onDateClick(function(event, date){
    var now = new Date();
    now.setHours(0, 0, 0, 0);

    if(date >= now) {
        var formattedDate = date.toISOString().slice(0, 10);
        appointmentDateInput.value = formattedDate;
        selectedDate = formattedDate;

        // remove chosen class from the previously chosen element
        if (selectedElement) {
            selectedElement.classList.remove('jsCalendar-selected');
        }
        // get the new chosen element and add the chosen class
        selectedElement = event.target;
        selectedElement.classList.add('jsCalendar-selected');
    }
});
