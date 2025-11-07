import 'package:itc/models/activity_type.dart';
import 'package:itc/utils/database_utility.dart';

import '../utils/database_helper.dart';

class ActivityService {

  ActivityService()  {}

  Future<List<Map<String, dynamic>>> getActivities() async {
    final db = await DatabaseHelper.instance.db;
    return await db.query(DatabaseUtility.activityTableName);
  }

  Future<ActivityType> getActivityByID(int id) async {
    final db = await DatabaseHelper.instance.db;
    List<Map<String, dynamic>> activity = await db.query(
        DatabaseUtility.activityTableName,
        where: 'id = ?',
        whereArgs: [id]
    );

    return ActivityType.fromMap(activity[0]);
  }
}