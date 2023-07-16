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

myCalendar.onDateClick(function(event, date){
    // Format date to 'yyyy-mm-dd' as it's the format that HTML date inputs use
    var formattedDate = date.toISOString().slice(0, 10);
    appointmentDateInput.value = formattedDate;
});