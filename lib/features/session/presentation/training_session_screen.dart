import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/homefit_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../workouts/domain/workout_models.dart';

class TrainingSessionScreen extends StatefulWidget {
  const TrainingSessionScreen(
      {super.key, required this.plan, required this.controller});
  final List<Exercise> plan;
  final HomeFitController controller;
  @override
  State<TrainingSessionScreen> createState() => _TrainingSessionScreenState();
}

class _TrainingSessionScreenState extends State<TrainingSessionScreen> {
  Timer? _timer;
  int _exerciseIndex = 0;
  late int _remainingSeconds = widget.plan.first.activeSeconds;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isRunning || !mounted) return;
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds -= 1);
      } else {
        _nextExercise();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _nextExercise() {
    if (_exerciseIndex == widget.plan.length - 1) {
      _finish();
      return;
    }
    setState(() {
      _exerciseIndex += 1;
      _remainingSeconds = widget.plan[_exerciseIndex].activeSeconds;
    });
  }

  void _finish() {
    _timer?.cancel();
    widget.controller.completeWorkout(durationMinutes: 30);
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(const SnackBar(
        content: Text('Training abgeschlossen. Stark gemacht!')));
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.plan[_exerciseIndex];
    final progress = (_exerciseIndex + 1) / widget.plan.length;
    final timerText =
        '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}';
    return Scaffold(
      body: AppPage(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Semantics(
            label:
                'Fortschritt: Übung ${_exerciseIndex + 1} von ${widget.plan.length}',
            child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                borderRadius: BorderRadius.circular(8),
                color: AppColors.forest,
                backgroundColor: AppColors.line)),
        const SizedBox(height: AppSpace.lg),
        Text('ÜBUNG ${_exerciseIndex + 1} VON ${widget.plan.length}',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColors.forest)),
        const SizedBox(height: AppSpace.xs),
        Text(exercise.name, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: AppSpace.xs),
        Text(exercise.repetitions,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.inkMuted)),
        const Spacer(),
        Center(
            child: Text(timerText,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 68, letterSpacing: -2))),
        const SizedBox(height: AppSpace.xs),
        Center(
            child: Text(
                _isRunning
                    ? 'Konzentriere dich auf saubere Bewegung.'
                    : 'Training pausiert',
                style: Theme.of(context).textTheme.bodyMedium)),
        const Spacer(),
        AppCard(
            color: AppColors.surfaceMuted,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.info_outline_rounded, color: AppColors.forest),
              const SizedBox(width: AppSpace.sm),
              Expanded(
                  child: Text(exercise.executionCue,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.ink)))
            ])),
        const SizedBox(height: AppSpace.md),
        Row(children: [
          Expanded(
              child: OutlinedButton(
                  onPressed: () => setState(() => _isRunning = !_isRunning),
                  child: Text(_isRunning ? 'Pause' : 'Weiter'))),
          const SizedBox(width: AppSpace.sm),
          Expanded(
              child: FilledButton(
                  onPressed: _nextExercise,
                  child: Text(_exerciseIndex == widget.plan.length - 1
                      ? 'Abschließen'
                      : 'Weiter')))
        ]),
      ])),
    );
  }
}
