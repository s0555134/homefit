import 'package:flutter/material.dart';

import '../../../app/homefit_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_widgets.dart';
import '../domain/workout_models.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key, required this.controller});
  final HomeFitController controller;

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile;
    final workout = controller.recommendedWorkout;
    return AppPage(
      child: ListView(
        children: [
          Text('HEUTE',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.forest)),
          const SizedBox(height: AppSpace.xs),
          Text('Zeit für dich.',
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: AppSpace.xs),
          Text('Dein Plan ist auf dein Zuhause abgestimmt.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSpace.lg),
          _TodayWorkoutCard(
              goal: profile.goal,
              exerciseCount: workout.length,
              onStart: controller.openTraining),
          const SizedBox(height: AppSpace.xl),
          const SectionHeader(title: 'Dein Fokus'),
          const SizedBox(height: AppSpace.sm),
          Text(profile.goal.description,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSpace.sm),
          Wrap(
              spacing: AppSpace.xs,
              runSpacing: AppSpace.xs,
              children: TrainingGoal.values
                  .map((goal) =>
                      Pill(label: goal.label, selected: goal == profile.goal))
                  .toList()),
          const SizedBox(height: AppSpace.xl),
          const SectionHeader(title: 'Diese Woche'),
          const SizedBox(height: AppSpace.sm),
          Row(children: [
            Expanded(
                child: MetricTile(
                    value: '${controller.completedWorkouts}',
                    label: 'Workouts',
                    icon: Icons.check_circle_outline_rounded)),
            const SizedBox(width: AppSpace.sm),
            Expanded(
                child: MetricTile(
                    value: '${controller.minutesTrained}',
                    label: 'Minuten',
                    icon: Icons.timer_outlined))
          ]),
        ],
      ),
    );
  }
}

class _TodayWorkoutCard extends StatelessWidget {
  const _TodayWorkoutCard(
      {required this.goal, required this.exerciseCount, required this.onStart});
  final TrainingGoal goal;
  final int exerciseCount;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpace.lg),
        decoration: const BoxDecoration(
            color: AppColors.forestDark, borderRadius: AppRadius.hero),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Pill(label: 'HEUTE EMPFOHLEN', dark: true),
          const SizedBox(height: AppSpace.lg),
          Text('${goal.label} Flow',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white)),
          const SizedBox(height: AppSpace.xs),
          Text('$exerciseCount Übungen · etwa 30 Minuten',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white.withValues(alpha: .76))),
          const SizedBox(height: AppSpace.lg),
          FilledButton.icon(
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.energy,
                  foregroundColor: AppColors.ink),
              onPressed: onStart,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Training ansehen')),
        ]),
      );
}
