import 'package:flutter/material.dart';
import 'package:flutter_assesment/Bloc/activity_cubit.dart';
import 'package:flutter_assesment/service/api_activity.dart';
import 'package:flutter_assesment/model/model.dart';
import 'package:flutter_assesment/view/history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  late String activityName = '';
  late double activityPrice = 0;
  late String activityType = '';
  String _selectedActivityType = '';

  Future<void> _fetchActivity() async {
    setState(() {
      _isLoading = true; 
    });
    try {
      Activity activity = await ActivityService.fetchActivity(_selectedActivityType);
      setState(() {
        activityName = activity.activity ?? "No activity available";
        activityPrice = activity.price ?? 0.0;
        activityType = activity.type ?? "No activity type";
        final activityCubit = context.read<ActivityCubit>();
        activityCubit.addActivity(activity);
      });
    } catch (e) {
      setState(() {
        activityName = "Failed to load activity";
        activityType = "None";
        activityPrice = 0;
      });
    } finally {
      setState(() {
        _isLoading = false; 
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final activityCubit = context.read<ActivityCubit>();
    Set<String> type = activityCubit.state.recentActivities.map((e) => e.type ?? '').toSet();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
     body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Text('Activity Name : $activityName'),
                      Text('Type : $activityType'),
                      Text('Price : $activityPrice')
                    ],
                  ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedActivityType.isEmpty ? null : _selectedActivityType,
              hint: Text("Select Activity Type"),
              onChanged: (String? newValue) {
                setState(() {
                _selectedActivityType = newValue ?? '';
                });
                activityCubit.setSelectedActivityType(_selectedActivityType); 
              },
              items: type.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _fetchActivity,
              child: Text('Next'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<ActivityCubit>(context),
                      child: const HistoryPage(),
                    ),
                  ),
                );
              },
              child: Text('History'),
            ),
          ],
        ),
    )
    );
  }
}
