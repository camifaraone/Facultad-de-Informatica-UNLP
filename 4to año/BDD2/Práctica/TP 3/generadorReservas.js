Date.prototype.addDays=function(d){return new Date(this.valueOf()+864E5*d);};
function randomDate(start, end) {
return new Date(start.getTime()+Math.random()*(end.getTime()-start.getTime()));
}
for (var i = 1; i <= 50000; i++) {
if (Math.random() > 0.7) {
var randomReservations = Math.ceil(Math.random() * 5);
for (var r = 1; r <= randomReservations; r++){
var startDate = randomDate(new Date(2012, 0, 1), new Date());
var days = Math.ceil(Math.random()*8);
var toDate = startDate.addDays(days);
var randomAmount = days * ((Math.random() * 100) + 80).toFixed(2);
db.reservations.insert({
apartmentName:'Apartment '+i,
from: startDate,
to: toDate,
amount: randomAmount
});}
}
}