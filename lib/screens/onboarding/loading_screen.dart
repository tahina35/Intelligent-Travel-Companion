import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../router/route_constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _currentStep = 0;
  bool _isCompleted = false;

  final List<LoadingStep> _loadingSteps = [
    LoadingStep("Detecting your location...", Icons.location_on),
    LoadingStep("Checking today's weather...", Icons.wb_sunny),
    LoadingStep("Personalizing recommendations...", Icons.psychology),
    LoadingStep("Getting everything ready...", Icons.star),
  ];

  @override
  void initState() {
    super.initState();

    // Start the step-by-step loading process
    _startLoadingSequence();
  }

  void _startLoadingSequence() async {
    for (int i = 0; i < _loadingSteps.length + 1; i++) {
      // Update the current step
      setState(() {
        _currentStep = i;
      });

      if(i < _loadingSteps.length) {
        // Wait before moving to next step (simulate work being done)
        await Future.delayed(Duration(milliseconds: 1800));
      }
    }

    setState(() {
      _isCompleted = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Spinner
              SpinKitWaveSpinner(
                color: Theme.of(context).colorScheme.primary,
                waveColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                trackColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                duration: const Duration(milliseconds:4000),
                size: 90.0,
              ),
              SizedBox(height: 40),
              Text(
                'Setting everything up...',
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 40),
              // Loading steps
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFAFA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: _loadingSteps.asMap().entries.map((entry) {
                      int index = entry.key;
                      LoadingStep step = entry.value;

                      return _buildStepRow(step, index);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: _isCompleted ? () {
            context.pushNamed(RouteConstants.home);
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            "Let\'s get started!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        ),
      );
  }

  Widget _buildStepRow(LoadingStep step, int index) {
    bool isCurrent = index == _currentStep;
    bool isCompleted = index < _currentStep;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            child: isCompleted
                ? Icon(
                      Icons.check,
                      size: 19,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                  )
                : isCurrent
                ? CircularProgressIndicator(strokeWidth: 2)
                : null,
          ),
          SizedBox(width: 16),
          Text(
            step.text,
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingStep {
  final String text;
  final IconData icon;

  LoadingStep(this.text, this.icon);
}