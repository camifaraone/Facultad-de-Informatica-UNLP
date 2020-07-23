for (var i = 1; i <= 50000; i++) {
	var randomServices = ['wifi', 'pool', 'parking', 'breakfast'].sort( function()
{ return 0.5 - Math.random() } ).slice(1, Math.floor(Math.random() * 5));
	var randomCapacity = Math.ceil(Math.random() * 5);
	var randomLong = ((Math.random()/1.3)+51);
	var randomLat = Math.random() - .4;
	db.apartments.insert({
		name:'Apartment'+i,
		capacity:randomCapacity,
		services: randomServices,
		location: {
			type: "Point",
			coordinates: [randomLat, randomLong]
		}
	});
}