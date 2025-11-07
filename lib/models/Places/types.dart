enum Types {

  // Food & Drink (Indoor-focused)
  restaurant(
      value: 'indoor',
      baseScore: 0.75,
      preferredHours: [
        PreferredHours(startHour: 11, endHour: 14),
        PreferredHours(startHour: 17, endHour: 22),
      ],
      peakHours: [
        PeakHours(startHour: 12, endHour: 13),
        PeakHours(startHour: 19, endHour: 20),
      ]
  ),

  cafe(
      value: 'indoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 6, endHour: 11),
      ],
      peakHours: [
        PeakHours(startHour: 7, endHour: 9),
      ]
  ),

  bar(
      value: 'indoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 18, endHour: 2),
      ],
      peakHours: [
        PeakHours(startHour: 20, endHour: 23),
      ]
  ),

  // Outdoor & Nature
  park(
      value: 'outdoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 6, endHour: 19),
      ],
      peakHours: [
        PeakHours(startHour: 9, endHour: 12),
        PeakHours(startHour: 15, endHour: 18),
      ]
  ),

  hiking_area(
      value: 'outdoor',
      baseScore: 0.55,
      preferredHours: [
        PreferredHours(startHour: 7, endHour: 19),
      ],
      peakHours: [
        PeakHours(startHour: 9, endHour: 11),
        PeakHours(startHour: 15, endHour: 17),
      ]
  ),

  barbecue_area(
      value: 'outdoor',
      baseScore: 0.5,
      preferredHours: [
        PreferredHours(startHour: 11, endHour: 20),
      ],
      peakHours: [
        PeakHours(startHour: 12, endHour: 14),
        PeakHours(startHour: 17, endHour: 19),
      ]
  ),

  botanical_garden(
      value: 'outdoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 8, endHour: 19),
      ],
      peakHours: [
        PeakHours(startHour: 9, endHour: 12),
        PeakHours(startHour: 14, endHour: 16),
      ]
  ),

// Cultural & Educational
  museum(
      value: 'indoor',
      baseScore: 0.7,
      preferredHours: [
        PreferredHours(startHour: 9, endHour: 17),
      ],
      peakHours: [
        PeakHours(startHour: 10, endHour: 12),
        PeakHours(startHour: 15, endHour: 17)
      ]
  ),

  art_gallery(
      value: 'indoor',
      baseScore: 0.65,
      preferredHours: [
        PreferredHours(startHour: 10, endHour: 18),
        PreferredHours(startHour: 18, endHour: 21),
      ],
      peakHours: [
        PeakHours(startHour: 10, endHour: 12),
        PeakHours(startHour: 15, endHour: 17)
      ]
  ),

  aquarium(
      value: 'indoor',
      baseScore: 0.65,
      preferredHours: [
        PreferredHours(startHour: 9, endHour: 18),
      ],
      peakHours: [
        PeakHours(startHour: 9.5, endHour: 11.5),
        PeakHours(startHour: 14.5, endHour: 17),
      ]
  ),

  cultural_center(
      value: 'indoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 9, endHour: 21),
      ],
      peakHours: [
        PeakHours(startHour: 9, endHour: 11),
        PeakHours(startHour: 14, endHour: 17),
      ]
  ),

  // Entertainment & Recreation
  movie_theater(
      value: 'indoor',
      baseScore: 0.7,
      preferredHours: [
        PreferredHours(startHour: 11, endHour: 23),
      ],
      peakHours: [
        PeakHours(startHour: 14, endHour: 16),
        PeakHours(startHour: 19, endHour: 21),
      ]
  ),

  amusement_park(
      value: 'outdoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 9, endHour: 20),
      ],
      peakHours: [
        PeakHours(startHour: 9, endHour: 11),
        PeakHours(startHour: 15, endHour: 17),
      ]
  ),

  stadium(
      value: 'outdoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 10, endHour: 23),
      ],
      peakHours: [
        PeakHours(startHour: 9, endHour: 12),
        PeakHours(startHour: 14, endHour: 17),
      ]
  ),

  spa(
      value: 'indoor',
      baseScore: 0.5,
      preferredHours: [
        PreferredHours(startHour: 8, endHour: 21),
      ],
      peakHours: [
        PeakHours(startHour: 10, endHour: 12),
        PeakHours(startHour: 14, endHour: 16),
      ]
  ),

  bowling_alley(
      value: 'indoor',
      baseScore: 0.5,
      preferredHours: [
        PreferredHours(startHour: 11, endHour: 23),
      ],
      peakHours: [
        PeakHours(startHour: 19, endHour: 22),
      ]
  ),

  gym(
      value: 'indoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 5, endHour: 23),
      ],
      peakHours: [
        PeakHours(startHour: 6, endHour: 8),
        PeakHours(startHour: 17, endHour: 19),
      ]
  ),

  // Public Spaces & Shopping
  shopping_mall(
      value: 'indoor',
      baseScore: 0.65,
      preferredHours: [
        PreferredHours(startHour: 9, endHour: 21),
      ],
      peakHours: [
        PeakHours(startHour: 11, endHour: 14),
        PeakHours(startHour: 16, endHour: 19),
      ]
  ),

  plaza(
      value: 'outdoor',
      baseScore: 0.5,
      preferredHours: [
        PreferredHours(startHour: 6, endHour: 22),
      ],
      peakHours: [
        PeakHours(startHour: 12, endHour: 14),
        PeakHours(startHour: 17, endHour: 19),
      ]
  ),

  campground(
      value: 'outdoor',
      baseScore: 0.45,
      preferredHours: [
        PreferredHours(startHour: 0, endHour: 24),
      ],
      peakHours: [
        PeakHours(startHour: 14, endHour: 18),   // Check-in time
        PeakHours(startHour: 8, endHour: 11),    // Morning activities
      ]
  ),

  library(
      value: 'indoor',
      baseScore: 0.55,
      preferredHours: [
        PreferredHours(startHour: 9, endHour: 20),
      ],
      peakHours: [
        PeakHours(startHour: 9, endHour: 12),   // Morning study
        PeakHours(startHour: 14, endHour: 16),   // Afternoon research
      ]
  ),

  book_store(
      value: 'indoor',
      baseScore: 0.5,
      preferredHours: [
        PreferredHours(startHour: 10, endHour: 20),
      ],
      peakHours: [
        PeakHours(startHour: 10, endHour: 11),   // Lunchtime browsing
        PeakHours(startHour: 15, endHour: 17),   // After work shopping
      ]
  ),

  night_club(
      value: 'indoor',
      baseScore: 0.4,
      preferredHours: [
        PreferredHours(startHour: 22, endHour: 3),
      ],
      peakHours: [
        PeakHours(startHour: 22, endHour: 1),    // Peak party hours
      ]
  ),

  karaoke(
      value: 'indoor',
      baseScore: 0.45,
      preferredHours: [
        PreferredHours(startHour: 18, endHour: 2),
      ],
      peakHours: [
        PeakHours(startHour: 19, endHour: 0),    // Evening singing
      ]
  ),

  water_park(
      value: 'outdoor',
      baseScore: 0.5,
      preferredHours: [
        PreferredHours(startHour: 10, endHour: 18),
      ],
      peakHours: [
        PeakHours(startHour: 12, endHour: 16),   // Mid-day fun
      ]
  ),

  roller_coaster(
      value: 'outdoor',
      baseScore: 0.45,
      preferredHours: [
        PreferredHours(startHour: 10, endHour: 20),
      ],
      peakHours: [
        PeakHours(startHour: 13, endHour: 17),   // Afternoon thrills
      ]
  ),

  opera_house(
      value: 'indoor',
      baseScore: 0.6,
      preferredHours: [
        PreferredHours(startHour: 10, endHour: 23),
      ],
      peakHours: [
        PeakHours(startHour: 14, endHour: 16),   // Matinee performances
        PeakHours(startHour: 19, endHour: 21),   // Evening shows
      ]
  ),

  beauty_salon(
      value: 'indoor',
      baseScore: 0.4,
      preferredHours: [
        PreferredHours(startHour: 9, endHour: 19),
      ],
      peakHours: [
        PeakHours(startHour: 10, endHour: 12),   // Lunchtime appointments
        PeakHours(startHour: 15, endHour: 17),   // After work pampering
      ]
  ),

  supermarket(
      value: 'indoor',
      baseScore: 0.35,
      preferredHours: [
        PreferredHours(startHour: 8, endHour: 22),
      ],
      peakHours: [
        PeakHours(startHour: 10, endHour: 12),   // Morning shopping
        PeakHours(startHour: 17, endHour: 19),   // After work rush
      ]
  ),

  arena(
      value: 'indoor',
      baseScore: 0.55,
      preferredHours: [
        PreferredHours(startHour: 10, endHour: 23),
      ],
      peakHours: [
        PeakHours(startHour: 13, endHour: 16),   // Afternoon events
        PeakHours(startHour: 19, endHour: 22),   // Evening events
      ]
  );



  final String value;
  final double baseScore;
  final List<PreferredHours> preferredHours;
  final List<PeakHours> peakHours;

  const Types({
    required this.value,
    required this.baseScore,
    required this.preferredHours,
    required this.peakHours
  });

  static List<String> getTypes() {
    return Types.values
        .map((type) => type.name)
        .toList();
  }

}

class TimeWindow {
  final double startHour;
  final double endHour;

  const TimeWindow({
    required this.startHour,
    required this.endHour
  });
}

class PreferredHours extends TimeWindow {
  const PreferredHours({required super.startHour, required super.endHour});
}

class PeakHours extends TimeWindow {
  const PeakHours({required super.startHour, required super.endHour});
}