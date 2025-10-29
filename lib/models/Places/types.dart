enum Type {

  restaurant(value: 'indoor'),
  cafe(value: 'indoor'),
  bakery(value: 'indoor'),
  bar(value: 'indoor'),
  meal_takeaway(value: 'indoor'),
  meal_delivery(value: 'outdoor'),
  tourist_attraction(value: 'outdoor'),
  museum(value: 'indoor'),
  art_gallery(value: 'indoor'),
  park(value: 'outdoor'),
  amusement_park(value: 'outdoor'),
  aquarium(value: 'indoor'),
  zoo(value: 'outdoor'),
  stadium(value: 'outdoor'),
  casino(value: 'indoor'),
  bowling_alley(value: 'indoor'),
  spa(value: 'indoor'),
  shopping_mall(value: 'indoor'),
  movie_theater(value: 'indoor'),
  book_store(value: 'indoor'),
  clothing_store(value: 'indoor'),
  jewelry_store(value: 'indoor'),
  shoe_store(value: 'indoor'),
  department_store(value: 'indoor'),
  florist(value: 'indoor'),
  night_club(value: 'indoor'),
  liquor_store(value: 'indoor'),
  church(value: 'indoor'),
  hindu_temple(value: 'indoor'),
  mosque(value: 'indoor'),
  synagogue(value: 'indoor'),
  cemetery(value: 'outdoor'),
  lodging(value: 'indoor'),
  campground(value: 'outdoor'),
  rv_park(value: 'outdoor');


  final String value;

  const Type({
    required this.value,
  });

  List<String> getIndoorTypes() {
    return Type.values
        .where((type) => type.value == 'indoor')
        .map((type) => type.name)
        .toList();
  }
  
  List<String> getOutdoorTypes() {
    return Type.values
        .where((type) => type.value == 'outdoor')
        .map((type) => type.name)
        .toList();
  }


}