import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itc/models/activity_type.dart';
import 'package:itc/models/preferences.dart';
import 'package:itc/screens/onboarding/activity_preference.dart';
import 'package:itc/screens/onboarding/food_preference.dart';
import 'package:itc/screens/onboarding/meal_time_preference.dart';
import 'package:itc/models/meal_time_preference.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentPage = 0;

  Preferences preferences = Preferences(
      active: true,
      activityType: ActivityType.origin(),
      mealTime: MealTimePreferences.origin(),
      foodPreferences: []
  );

  late List<Widget> screens = [
    ActivityPreference(preferences: preferences),
    FoodPreference(preferences: preferences),
    MealTimePreference(preferences: preferences),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  void selectedActivityType() {

  }

  void nextPage() {
    setState(() {
      if (currentPage < screens.length - 1) {
        currentPage++;
      } else {
        Navigator.pushNamed(context, '/');
      }
    });
    _pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);

    //print(preferences.mealTime.breakfast.start);
  }

  void previousPage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
    _pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: currentPage != 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: TextButton.icon(
                  onPressed: previousPage,
                  icon: Icon(
                      Icons.chevron_left,
                      size: 25,
                      color: Colors.black
                  ),
                  label: Text(
                      'Back',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                      ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 14,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: screens.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) => screens[index]
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  screens.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: DotIndicator(isActive: index == currentPage),
                      ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  (currentPage == screens.length - 1) ? "Done" : "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    Color activeColor = Theme.of(context).colorScheme.primary;
    Color inActiveColor = const Color(0xFF868686);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 6,
      width: isActive ? 20 : 6,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

