import 'package:flutter/foundation.dart';

import '../features/workouts/data/exercise_repository.dart';
import '../features/workouts/domain/workout_models.dart';

class HomeFitController extends ChangeNotifier {
  HomeFitController({ExerciseRepository? exerciseRepository})
      : _exerciseRepository =
            exerciseRepository ?? const DemoExerciseRepository();

  final ExerciseRepository _exerciseRepository;
  late final List<Exercise> _exercises = _exerciseRepository.getAll();
  WorkoutProfile _profile = const WorkoutProfile(
      goal: TrainingGoal.fullBody, availableEquipment: {Equipment.mat});
  int _navigationIndex = 0;
  int _completedWorkouts = 4;
  int _minutesTrained = 120;
  int _streak = 3;

  WorkoutProfile get profile => _profile;
  int get navigationIndex => _navigationIndex;
  int get completedWorkouts => _completedWorkouts;
  int get minutesTrained => _minutesTrained;
  int get streak => _streak;
  List<Exercise> get recommendedWorkout => _exercises
      .where((exercise) => exercise.requiredEquipment
          .every(_profile.availableEquipment.contains))
      .take(5)
      .toList(growable: false);

  void selectNavigation(int index) {
    _navigationIndex = index;
    notifyListeners();
  }

  void updateProfile(WorkoutProfile profile) {
    _profile = profile;
    notifyListeners();
  }

  void openTraining() => selectNavigation(1);
  void completeWorkout({required int durationMinutes}) {
    _completedWorkouts += 1;
    _minutesTrained += durationMinutes;
    _streak += 1;
    notifyListeners();
  }
}
