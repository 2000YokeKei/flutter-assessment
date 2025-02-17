import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class ActivityService {
 static const String baseUrl = 'https://bored.api.lewagon.com/api/activity/';

  static Future<Activity> fetchActivity() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Activity.fromJson(data);
      } else {
        throw Exception('Failed to load activity');
      }
    } catch (e) {
      throw Exception('Error fetching activity: $e');
    }
  }
}
