import 'dart:convert';

import 'package:flutter_assesment/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityState {
  final List<Activity> recentActivities;
  final String selectedActivityType;

  ActivityState({required this.recentActivities, required this.selectedActivityType});
}

class ActivityCubit extends Cubit<ActivityState> {
  static const int _maxActivities = 50;

  ActivityCubit() : super(ActivityState(recentActivities: [], selectedActivityType: '')) {
    _loadState();
  }

  void addActivity(Activity activity) {
    final updatedActivities = List<Activity>.from(state.recentActivities);

    updatedActivities.add(activity);
    if (updatedActivities.length > _maxActivities) {
      updatedActivities.removeAt(0);
    }

    emit(ActivityState(recentActivities: updatedActivities, selectedActivityType: state.selectedActivityType));
    _saveState(); 
  }

  // Set the selected activity type
  void setSelectedActivityType(String type) {
    emit(ActivityState(recentActivities: state.recentActivities, selectedActivityType: type));
    _saveState(); 
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    final activitiesJson = jsonEncode(state.recentActivities.map((activity) => activity.toJson()).toList());
    await prefs.setString('recentActivities', activitiesJson);
    await prefs.setString('selectedActivityType', state.selectedActivityType);
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final activitiesJson = prefs.getString('recentActivities');
    final recentActivities = activitiesJson != null
        ? (jsonDecode(activitiesJson) as List).map((json) => Activity.fromJson(json)).toList()
        : <Activity>[];
    final limitedActivities = recentActivities.length > _maxActivities
        ? recentActivities.sublist(recentActivities.length - _maxActivities)
        : recentActivities;
    final selectedActivityType = prefs.getString('selectedActivityType') ?? '';
    emit(ActivityState(recentActivities: limitedActivities, selectedActivityType: selectedActivityType));
  }
}