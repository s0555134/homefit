import 'package:flutter/material.dart';

import '../../../app/homefit_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../session/presentation/training_session_screen.dart';
import '../domain/workout_models.dart';
import 'exercise_detail_screen.dart';

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key, required this.controller});
  final HomeFitController controller;

  @override
  Widget build(BuildContext context) {
    final plan = controller.recommendedWorkout;
    return AppPage(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('DEIN TRAINING',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColors.forest)),
        const SizedBox(height: AppSpace.xs),
        Text('${controller.profile.goal.label} Flow',
            style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: AppSpace.xs),
        Text('${plan.length} Übungen · etwa 30 Minuten · ohne Gerätezwang',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSpace.lg),
        Expanded(
          child: ListView.separated(
            itemCount: plan.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpace.xs),
            itemBuilder: (_, index) => ExerciseListItem(
                exercise: plan[index],
                number: index + 1,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        ExerciseDetailScreen(exercise: plan[index])))),
          ),
        ),
        const SizedBox(height: AppSpace.md),
        FilledButton.icon(
            onPressed: plan.isEmpty
                ? null
                : () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TrainingSessionScreen(
                        plan: plan, controller: controller))),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Training starten')),
      ]),
    );
  }
}

class ExerciseListItem extends StatelessWidget {
  const ExerciseListItem(
      {super.key,
      required this.exercise,
      required this.number,
      required this.onTap});
  final Exercise exercise;
  final int number;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label:
            '$number. ${exercise.name}, ${exercise.sets} Sätze, ${exercise.repetitions}',
        child: AppCard(
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.card,
            child: Padding(
              padding: const EdgeInsets.all(AppSpace.md),
              child: Row(children: [
                Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.surfaceMuted, shape: BoxShape.circle),
                    child: Text('$number',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: AppColors.forest))),
                const SizedBox(width: AppSpace.sm),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(exercise.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: AppSpace.xxs),
                      Text('${exercise.sets} Sätze · ${exercise.repetitions}',
                          style: Theme.of(context).textTheme.bodyMedium)
                    ])),
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.inkMuted),
              ]),
            ),
          ),
        ),
      );
}
