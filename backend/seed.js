const mongoose = require("mongoose");
const City = require("./models/city.model");

mongoose
	.connect(
		"mongodb+srv://loic:pass@cluster0-cgysw.gcp.mongodb.net/dymatrip?retryWrites=true&w=majority",
		{
			useNewUrlParser: true
		}
	)
	.then(() => {
		Promise.all([
			new City({
				name: "Paris",
				image: "http://10.0.2.2/assets/images/paris.jpeg",
				activities: [
					{
						image: "http://10.0.2.2/assets/images/activities/chaumont.jpg",
						name: "Chaumont",
						city: "Paris",
						price: 12.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/la-defense.jpg",
						name: "La Défense",
						city: "Paris",
						price: 0.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/le-marais.jpg",
						name: "Le Marais",
						city: "Paris",
						price: 0.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/louvre.jpg",
						name: "Le Marais",
						city: "Paris",
						price: 0.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/notre-dame.jpg",
						name: "Nôtre Dame",
						city: "Paris",
						price: 15.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/stade.jpg",
						name: "Stade de France",
						id: "a6",
						city: "Paris",
						price: 0.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/disney.jpg",
						name: "DisneyLand Paris",
						id: "a7",
						city: "Paris",
						price: 0.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/catacombes.jpg",
						name: "Catacombes",
						id: "a8",
						city: "Paris",
						price: 0.0
					}
				]
			}).save(),
			new City({
				name: "Amsterdam",
				image: "http://10.0.2.2/assets/images/amsterdam.jpeg",
				activities: [
					{
						image: "http://10.0.2.2/assets/images/activities/peniche.jpg",
						name: "Péniche",
						id: "l1",
						city: "Amsterdam",
						price: 100.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/bar.jpg",
						name: "IceBAr",
						id: "l2",
						city: "Amsterdam",
						price: 0.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/red.jpg",
						name: "RedLight",
						id: "l3",
						city: "Amsterdam",
						price: 10.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/tulipe.jpg",
						name: "Champs de Tulipes",
						id: "l4",
						city: "Amsterdam",
						price: 0.0
					}
				]
			}).save(),
			new City({
				name: "Melbourne",
				image: "http://10.0.2.2/assets/images/melbourne.jpeg",
				activities: [
					{
						image: "http://10.0.2.2/assets/images/activities/footy.jpg",
						name: "Match Footy",
						id: "n1",
						city: "Melbourne",
						price: 5.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/parc.jpg",
						name: "Parc",
						id: "n2",
						city: "Melbourne",
						price: 0.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/star.jpg",
						name: "StarObservation",
						id: "n3",
						city: "Melbourne",
						price: 10.0
					},
					{
						image: "http://10.0.2.2/assets/images/activities/lunaparc.jpg",
						name: "Lunaparc",
						id: "n4",
						city: "Melbourne",
						price: 100.0
					}
				]
			}).save()
		]).then((res) => {
			console.log("data installed");
			mongoose.connection.close();
		});
	});
