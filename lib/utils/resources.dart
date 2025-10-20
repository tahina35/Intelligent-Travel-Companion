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

}