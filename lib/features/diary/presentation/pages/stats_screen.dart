import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evotest/features/diary/presentation/bloc/stats/stats_bloc.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StatsBloc>().add(GetStatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state is StatsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StatsLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildStatsSection(state.statsData),
                  const SizedBox(height: 20),
                  _buildMoodsList(state.moods),
                ],
              ),
            );
          } else if (state is StatsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Failed to load stats'));
          }
        },
      ),
    );
  }

  Widget _buildStatsSection(Map<String, dynamic> statsData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Entries: ${statsData['totalEntries']}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Average Stress Level: ${statsData['averageStressLevel'].toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Average Self-Esteem Level: ${statsData['averageSelfEsteemLevel'].toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Most Common Feeling: ${statsData['mostCommonFeeling']}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodsList(List moods) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: moods.length,
      itemBuilder: (context, index) {
        final mood = moods[index];
        return ListTile(
          title: Text(mood.feeling),
          subtitle: Text(
            'Stress: ${mood.stressLevel}, Self-Esteem: ${mood.selfEsteemLevel}\nNote: ${mood.note}',
          ),
          trailing: Text(mood.date.toString().split(' ')[0]),
        );
      },
    );
  }
}
