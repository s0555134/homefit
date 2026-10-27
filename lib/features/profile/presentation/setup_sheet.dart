import 'package:flutter/material.dart';

import '../../../app/homefit_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../workouts/domain/workout_models.dart';

class SetupSheet extends StatefulWidget {
  const SetupSheet({super.key, required this.controller});
  final HomeFitController controller;
  @override
  State<SetupSheet> createState() => _SetupSheetState();
}

class _SetupSheetState extends State<SetupSheet> {
  late TrainingGoal goal = widget.controller.profile.goal;
  late Set<Equipment> equipment = {
    ...widget.controller.profile.availableEquipment
  };

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
        initialChildSize: .78,
        minChildSize: .55,
        maxChildSize: .94,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
              color: AppColors.canvas,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(
                AppSpace.page, AppSpace.sm, AppSpace.page, AppSpace.xl),
            children: [
              Center(
                  child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                          color: AppColors.line,
                          borderRadius: BorderRadius.circular(4)))),
              const SizedBox(height: AppSpace.lg),
              Text('Dein Trainingsprofil',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSpace.xs),
              Text(
                  'Wir passen deine Empfehlungen an dein Ziel und dein Zuhause an.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppSpace.lg),
              Text('Worauf liegt dein Fokus?',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpace.sm),
              Wrap(
                  spacing: AppSpace.xs,
                  runSpacing: AppSpace.xs,
                  children: TrainingGoal.values
                      .map((item) => ChoiceChip(
                          label: Text(item.label),
                          selected: goal == item,
                          onSelected: (_) => setState(() => goal = item)))
                      .toList()),
              const SizedBox(height: AppSpace.lg),
              Text('Dein Equipment',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpace.xs),
              Text('Wähle nur aus, was dir wirklich zur Verfügung steht.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppSpace.sm),
              Wrap(
                  spacing: AppSpace.xs,
                  runSpacing: AppSpace.xs,
                  children: Equipment.values
                      .map((item) => FilterChip(
                          label: Text(item.label),
                          selected: equipment.contains(item),
                          onSelected: (selected) => setState(() => selected
                              ? equipment.add(item)
                              : equipment.remove(item))))
                      .toList()),
              const SizedBox(height: AppSpace.xl),
              FilledButton(
                  onPressed: () {
                    widget.controller.updateProfile(WorkoutProfile(
                        goal: goal, availableEquipment: equipment));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Plan aktualisieren')),
            ],
          ),
        ),
      );
}
