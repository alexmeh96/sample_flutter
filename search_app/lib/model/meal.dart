class Meal {
  final String id;
  final String name;
  final String img;
  final String restaurant;
  final int price;
  final String description;
  final double lat;
  final double lng;
  final String category;
  final int mass;
  final int kkal;
  final int fat;
  final int prot;
  final int carb;
  final String restaurantId;
  int date;
  final bool ownMeal;

  Meal({
    this.id,
    this.name,
    this.img,
    this.restaurant,
    this.price,
    this.description,
    this.lat,
    this.lng,
    this.category,
    this.mass,
    this.kkal,
    this.fat,
    this.prot,
    this.carb,
    this.restaurantId,
    this.date,
    this.ownMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['id'],
        name: json['name'],
        img: json['img'],
        restaurant: json['restaurant'],
        price: json['price'],
        description: json['description'],
        lat: json['location'] != null
            ? json['location']['coordinates'][1]
            : null,
        lng: json['location'] != null
            ? json['location']['coordinates'][0]
            : null,
        category: json['category'],
        mass: json['mass'],
        kkal: json['kkal'],
        fat: json['fat'],
        prot: json['prot'],
        carb: json['carb'],
        restaurantId: json['restaurantId'],
        date: json['date'],
        ownMeal: json['ownMeal'] != null ? json['ownMeal'] : false,
      );

  Map toJson() {
    List coordinates = [lng, lat];
    return {
      'id': id,
      'name': name,
      'img': img,
      'restaurant': restaurant,
      'price': price,
      'description': description,
      'location': {"coordinates": coordinates},
      // 'lat': lat,
      // 'lng': lng,
      'category': category,
      'mass': mass,
      'kkal': kkal,
      'fat': fat,
      'prot': prot,
      'carb': carb,
      'restaurantId': restaurantId,
      'date': date,
      'ownMeal': ownMeal,
    };
  }

  @override
  String toString() {
    return 'Meal{id: $id, name: $name, img: $img, restaurant: $restaurant, price: $price, describe: $description, lat: $lat, lng: $lng, category: $category, mass: $mass, kkal: $kkal, fat: $fat, prot: $prot, carb: $carb, restaurantId: $restaurantId, date: $date, ownMeal: $ownMeal}';
  }
}
