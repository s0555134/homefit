enum TrainingGoal { strength, mobility, endurance, fullBody }

extension TrainingGoalLabel on TrainingGoal {
  String get label => switch (this) {
        TrainingGoal.strength => 'Kraft',
        TrainingGoal.mobility => 'Beweglichkeit',
        TrainingGoal.endurance => 'Ausdauer',
        TrainingGoal.fullBody => 'Ganzkörper',
      };

  String get description => switch (this) {
        TrainingGoal.strength => 'Kontrollierte Wiederholungen für mehr Kraft.',
        TrainingGoal.mobility => 'Bewege dich freier und stabiler.',
        TrainingGoal.endurance =>
          'Erhöhe deine Belastbarkeit Schritt für Schritt.',
        TrainingGoal.fullBody =>
          'Ein ausgewogenes Training für den ganzen Körper.',
      };
}

enum Equipment { mat, dumbbells, resistanceBand, kettlebell, pullUpBar, chair }

extension EquipmentLabel on Equipment {
  String get label => switch (this) {
        Equipment.mat => 'Trainingsmatte',
        Equipment.dumbbells => 'Hanteln',
        Equipment.resistanceBand => 'Widerstandsband',
        Equipment.kettlebell => 'Kettlebell',
        Equipment.pullUpBar => 'Klimmzugstange',
        Equipment.chair => 'Stuhl',
      };
}

class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.sets,
    required this.repetitions,
    required this.activeSeconds,
    required this.executionCue,
    required this.requiredEquipment,
    this.commonMistake,
  });

  final String id;
  final String name;
  final String muscleGroup;
  final int sets;
  final String repetitions;
  final int activeSeconds;
  final String executionCue;
  final String? commonMistake;
  final Set<Equipment> requiredEquipment;
}

class WorkoutProfile {
  const WorkoutProfile({required this.goal, required this.availableEquipment});

  final TrainingGoal goal;
  final Set<Equipment> availableEquipment;

  WorkoutProfile copyWith({
    TrainingGoal? goal,
    Set<Equipment>? availableEquipment,
  }) =>
      WorkoutProfile(
        goal: goal ?? this.goal,
        availableEquipment: availableEquipment ?? this.availableEquipment,
      );
}
