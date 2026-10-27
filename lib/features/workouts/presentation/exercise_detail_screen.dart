import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_widgets.dart';
import '../domain/workout_models.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key, required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Übungsdetails')),
        body: AppPage(
          child: ListView(children: [
            Container(
              height: 208,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.surfaceMuted, borderRadius: AppRadius.hero),
              child: const Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.video_library_outlined,
                    size: 34, color: AppColors.forest),
                SizedBox(height: AppSpace.sm),
                Text('Video-Demonstration folgt',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: AppColors.forest)),
                SizedBox(height: AppSpace.xxs),
                Text('Nur mit fachlich geprüften, lizenzierten Assets.',
                    style: TextStyle(color: AppColors.inkMuted))
              ]),
            ),
            const SizedBox(height: AppSpace.lg),
            Text(exercise.name,
                style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: AppSpace.xs),
            Text(exercise.muscleGroup,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.forest)),
            const SizedBox(height: AppSpace.lg),
            Row(children: [
              Expanded(
                  child: MetricTile(
                      value: '${exercise.sets}',
                      label: 'Sätze',
                      icon: Icons.repeat_rounded)),
              const SizedBox(width: AppSpace.sm),
              Expanded(
                  child: MetricTile(
                      value: exercise.repetitions,
                      label: 'Umfang',
                      icon: Icons.fitness_center_rounded))
            ]),
            const SizedBox(height: AppSpace.xl),
            const SectionHeader(title: 'Ausführung'),
            const SizedBox(height: AppSpace.sm),
            AppCard(
                child: Text(exercise.executionCue,
                    style: Theme.of(context).textTheme.bodyLarge)),
            if (exercise.commonMistake != null) ...[
              const SizedBox(height: AppSpace.sm),
              AppCard(
                  color: const Color(0xFFFFF4E5),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.tips_and_updates_outlined,
                            color: Color(0xFF8A4B00)),
                        const SizedBox(width: AppSpace.sm),
                        Expanded(
                            child: Text(
                                'Achte darauf: ${exercise.commonMistake}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.ink)))
                      ])),
            ],
            const SizedBox(height: AppSpace.lg),
            const Text(
                'Beende die Übung bei Schmerzen. HomeFit ersetzt keine medizinische Beratung.',
                style: TextStyle(
                    fontSize: 12, height: 1.4, color: AppColors.inkMuted)),
          ]),
        ),
      );
}
