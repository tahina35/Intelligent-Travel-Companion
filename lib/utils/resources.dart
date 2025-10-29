class Resources {

  //GOOGLE PLACES API
  static const api_key = 'AIzaSyCUWT2_DxJnmtL9vdB52Zs39p5UUyy-eRs';
  static const google_places_api_baseurl = 'places.googleapis.com';
  static const google_distance_matrix_baseurl = 'maps.googleapis.com';

  static const max_result_count = 10;
  static const field_mask = 'places.displayName,places.formattedAddress,places.name,'
                            'places.location,places.photos,places.types,'
                            'places.rating,places.userRatingCount,'
                            'places.regularOpeningHours';

  static const image_max_width = 1024;
  static const image_max_height = 768;

  static const included_primary_types = [
    // Food & Dining
    'restaurant', 'cafe', 'bakery', 'bar', 'meal_takeaway', 'meal_delivery',
    // Attractions & Activities
    'tourist_attraction', 'museum', 'art_gallery', 'park', 'amusement_park',
    'aquarium', 'zoo', 'stadium', 'casino', 'bowling_alley', 'spa',
    // Shopping & Entertainment
    'shopping_mall', 'movie_theater', 'book_store', 'clothing_store',
    'jewelry_store', 'shoe_store', 'department_store', 'florist',
    // Nightlife & Social
    'night_club', 'liquor_store',
    // Cultural & Religious
    'church', 'hindu_temple', 'mosque', 'synagogue', 'cemetery',
    // Accommodation
    'lodging',
    // Outdoor & Nature
    'campground', 'rv_park'
  ];

  static const indoor_activity_types = [
    'restaurant', 'cafe', 'bakery', 'bar', 'meal_takeaway', 'meal_delivery',
    'museum', 'art_gallery', 'shopping_mall', 'movie_theater', 'book_store',
    'clothing_store', 'jewelry_store', 'shoe_store', 'department_store',
    'florist', 'night_club', 'liquor_store', 'casino', 'bowling_alley',
    'spa', 'lodging', 'church', 'hindu_temple', 'mosque', 'synagogue'
  ];

  static const outdoor_activity_types = [
    'park', 'campground', 'rv_park', 'stadium',
    'tourist_attraction', 'cemetery', 'zoo', 'amusement_park'
  ];

}