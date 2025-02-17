import 'package:flutter_assesment/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityState {
  final List<Activity> recentActivities;

  ActivityState({this.recentActivities = const []});

  ActivityState copyWith({List<Activity>? recentActivities}) {
    return ActivityState(
      recentActivities: recentActivities ?? this.recentActivities,
    );
  }
}


class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityState());

  void addActivity(Activity activity) {
    final updatedActivities = List<Activity>.from(state.recentActivities);
    updatedActivities.insert(0, activity);


    if (updatedActivities.length > 50) {
      updatedActivities.removeLast();
    }

    emit(state.copyWith(recentActivities: updatedActivities));
    print('Added activity: ${activity.activity}, Total: ${updatedActivities.length}');
  }

  // Clear all activities
  void clearActivities() {
    emit(state.copyWith(recentActivities: []));
    print('Cleared all activities');
  }
}
