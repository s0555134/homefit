import 'package:flutter/material.dart';

import '../../../app/homefit_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_widgets.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key, required this.controller});
  final HomeFitController controller;

  @override
  Widget build(BuildContext context) => AppPage(
        child: ListView(children: [
          Text('FORTSCHRITT',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.forest)),
          const SizedBox(height: AppSpace.xs),
          Text('Deine Routine wächst.',
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: AppSpace.xs),
          Text('Jede absolvierte Einheit zählt.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSpace.lg),
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
          const SizedBox(height: AppSpace.xl),
          AppCard(
              color: AppColors.forestDark,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('DEINE SERIE',
                        style: TextStyle(
                            color: Color(0xFFB6D7C2),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .5)),
                    const SizedBox(height: AppSpace.xs),
                    Text('${controller.streak} Tage in Folge',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.white)),
                    const SizedBox(height: AppSpace.lg),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeekDay(label: 'M', active: true),
                          WeekDay(label: 'D', active: true),
                          WeekDay(label: 'M', active: true),
                          WeekDay(label: 'D'),
                          WeekDay(label: 'F'),
                          WeekDay(label: 'S'),
                          WeekDay(label: 'S')
                        ]),
                  ])),
          const SizedBox(height: AppSpace.xl),
          const SectionHeader(title: 'Nächster Schritt'),
          const SizedBox(height: AppSpace.sm),
          AppCard(
              child: Text(
                  'Wähle in deinem Trainingsprofil ein Ziel und dein verfügbares Equipment. HomeFit stellt daraus deinen nächsten Plan zusammen.',
                  style: Theme.of(context).textTheme.bodyLarge)),
        ]),
      );
}

class WeekDay extends StatelessWidget {
  const WeekDay({super.key, required this.label, this.active = false});
  final String label;
  final bool active;
  @override
  Widget build(BuildContext context) => Semantics(
      label: '$label ${active ? 'abgeschlossen' : 'noch offen'}',
      child: CircleAvatar(
          radius: 16,
          backgroundColor:
              active ? AppColors.energy : Colors.white.withValues(alpha: .16),
          foregroundColor: active ? AppColors.ink : Colors.white,
          child: Text(label,
              style: const TextStyle(fontWeight: FontWeight.w700))));
}
