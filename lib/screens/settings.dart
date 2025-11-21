import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/route_constants.dart';
import '../services/notification_service.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final notificationService = NotificationService();

  bool isNotificationEnabled = true;

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
  }

  void _checkNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isEnabled = prefs.getBool(NotificationService.notificationEnabledKey)!;

    setState(() {
      isNotificationEnabled = isEnabled;
    });
  }

  Future<void> _handleNotificationSwitch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    print(value);

    if (value) {

      setState(() {
        isNotificationEnabled = true;
      });

      await prefs.setBool(NotificationService.notificationEnabledKey, true);

    } else {

      setState(() {
        isNotificationEnabled = false;
      });

      await prefs.setBool(NotificationService.notificationEnabledKey, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 100.0,
              surfaceTintColor: const Color(0xFFF7F7F7),
              backgroundColor: const Color(0xFFF7F7F7),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: const Color(0xFFF7F7F7), // Page background color
                ),
                titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                title: Text(
                  "Settings",
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _SingleSection(
                          title: "Preferences",
                          children: [
                            _CustomListTile(
                              title: "Activity Preference",
                              icon: Icons.local_activity_outlined,
                              callback: () {
                                context.pushNamed(RouteConstants.edit_activity_preferences);
                              },
                            ),
                            _CustomListTile(
                              title: "Food Preferences",
                              icon: Icons.restaurant_outlined,
                              callback: () {
                                context.pushNamed(RouteConstants.edit_food_preferences);
                              },
                            ),
                            _CustomListTile(
                              title: "Meal Time Preferences",
                              icon: CupertinoIcons.clock,
                              callback: () {
                                context.pushNamed(RouteConstants.edit_meal_time_preferences);
                              },
                            ),
                          ],
                        ),
                        _SingleSection(
                          title: "Notifications",
                          children: [
                            _CustomListTile(
                              title: "Enable Notifications",
                              icon: CupertinoIcons.bell,
                              trailing: Switch(
                                value: isNotificationEnabled,
                                onChanged: (value) {
                                  _handleNotificationSwitch(value);
                                },
                                activeThumbColor: Colors.white,
                                activeTrackColor: Colors.green[400],
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey[300],
                                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                              ),
                              callback: null
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final GestureTapCallback? callback;
  _CustomListTile({
    required this.title,
    required this.icon,
    this.callback,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      leading: Icon(icon),
      onTap: callback,
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  _SingleSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.titleMedium,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5
            ),
          ),
        ),
        Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
