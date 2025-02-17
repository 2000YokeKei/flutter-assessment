import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_assesment/Bloc/activity_cubit.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Activity History'),
      ),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          final activities = state.recentActivities;

          if (activities.isEmpty) {
            return Center(
              child: Text('No activities in history yet.'),
            );
          }

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ListTile(
                title: Text(activity.activity ?? 'No Activity Name'),
                subtitle: Text('Price: \$${activity.price?.toStringAsFixed(2) ?? '0.00'}'),
              );
            },
          );
        },
      ),
    );
  }
}
