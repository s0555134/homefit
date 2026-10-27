import '../domain/workout_models.dart';

abstract interface class ExerciseRepository {
  List<Exercise> getAll();
}

class DemoExerciseRepository implements ExerciseRepository {
  const DemoExerciseRepository();

  @override
  List<Exercise> getAll() => const [
        Exercise(
            id: 'squat',
            name: 'Kniebeugen',
            muscleGroup: 'Beine & Gesäß',
            sets: 3,
            repetitions: '12 Wiederholungen',
            activeSeconds: 40,
            executionCue:
                'Stell die Füße etwa hüftbreit auf. Schiebe die Hüfte nach hinten und halte den Brustkorb aufrecht.',
            commonMistake:
                'Lass die Knie nicht nach innen kippen und hebe die Fersen nicht ab.',
            requiredEquipment: {}),
        Exercise(
            id: 'push-up',
            name: 'Liegestütze',
            muscleGroup: 'Brust & Trizeps',
            sets: 3,
            repetitions: '8–12 Wiederholungen',
            activeSeconds: 35,
            executionCue:
                'Spanne Bauch und Gesäß an. Senke den Brustkorb kontrolliert zwischen die Hände.',
            commonMistake: 'Vermeide ein Durchhängen im unteren Rücken.',
            requiredEquipment: {}),
        Exercise(
            id: 'glute-bridge',
            name: 'Glute Bridge',
            muscleGroup: 'Gesäß & Core',
            sets: 3,
            repetitions: '15 Wiederholungen',
            activeSeconds: 35,
            executionCue:
                'Drücke über die Fersen und strecke die Hüfte, bis Oberschenkel und Oberkörper eine Linie bilden.',
            commonMistake: 'Überstrecke nicht den unteren Rücken.',
            requiredEquipment: {Equipment.mat}),
        Exercise(
            id: 'band-row',
            name: 'Rudern mit Band',
            muscleGroup: 'Rücken & Bizeps',
            sets: 3,
            repetitions: '12 Wiederholungen',
            activeSeconds: 40,
            executionCue:
                'Ziehe die Ellbogen nach hinten und führe die Schulterblätter bewusst zusammen.',
            commonMistake: 'Ziehe nicht die Schultern zu den Ohren.',
            requiredEquipment: {Equipment.resistanceBand}),
        Exercise(
            id: 'plank',
            name: 'Plank',
            muscleGroup: 'Core',
            sets: 3,
            repetitions: '30 Sekunden',
            activeSeconds: 30,
            executionCue:
                'Stütze dich stabil ab und ziehe den Bauchnabel sanft zur Wirbelsäule.',
            commonMistake: 'Lass das Becken weder durchhängen noch zu hoch steigen.',
            requiredEquipment: {Equipment.mat}),
        Exercise(
            id: 'lunge',
            name: 'Ausfallschritte',
            muscleGroup: 'Beine & Balance',
            sets: 3,
            repetitions: '10 je Seite',
            activeSeconds: 40,
            executionCue:
                'Mach einen langen Schritt zurück und halte das vordere Knie über dem Fuß.',
            commonMistake: 'Vermeide kurze, instabile Schritte.',
            requiredEquipment: {}),
      ];
}
