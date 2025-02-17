import 'package:flutter_assesment/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityState {
  final List<Activity> recentActivities;
  final String selectedActivityType;

  ActivityState({this.recentActivities = const [], this.selectedActivityType = ''});

  ActivityState copyWith({List<Activity>? recentActivities, String? selectedActivityType}) {
    return ActivityState(
      recentActivities: recentActivities ?? this.recentActivities,
      selectedActivityType: selectedActivityType ?? this.selectedActivityType,
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
  }

  void setSelectedActivityType(String type) {
    emit(state.copyWith(selectedActivityType: type));
  }
}
