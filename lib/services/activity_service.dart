import '../utils/database_helper.dart';

class ActivityService {

  ActivityService()  {}

  Future<List<Map<String, dynamic>>> getActivities() async {
    final db = await DatabaseHelper.instance.db;
    return await db.query('activity');
  }
}