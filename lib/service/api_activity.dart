import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class ActivityService {
  static Future<Activity> fetchActivity(String? type) async {
     late String baseUrl = '';
    if(type == null){
      baseUrl = 'https://bored.api.lewagon.com/api/activity/';
    }else{
      baseUrl = 'https://bored.api.lewagon.com/api/activity/?type=$type';
    }

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
