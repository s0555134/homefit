import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const HomeFitApp());

class AppColors {
  static const ink = Color(0xFF19251F);
  static const moss = Color(0xFF315C48);
  static const mint = Color(0xFFB9E6CB);
  static const lime = Color(0xFFD9FA8B);
  static const cream = Color(0xFFF7F5EF);
  static const sand = Color(0xFFE8E5DC);
}

class HomeFitApp extends StatelessWidget {
  const HomeFitApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'HomeFit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.cream,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.moss,
            brightness: Brightness.light,
            surface: AppColors.cream,
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: AppColors.ink, height: 1.08),
            headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.ink),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink),
            bodyLarge: TextStyle(fontSize: 16, color: AppColors.ink, height: 1.45),
          ),
        ),
        home: const HomeShell(),
      );
}

enum Goal { strength, mobility, endurance, fullBody }

extension GoalCopy on Goal {
  String get label => switch (this) { Goal.strength => 'Kraft', Goal.mobility => 'Beweglichkeit', Goal.endurance => 'Ausdauer', Goal.fullBody => 'Ganzkörper' };
  IconData get icon => switch (this) { Goal.strength => Icons.fitness_center_rounded, Goal.mobility => Icons.self_improvement_rounded, Goal.endurance => Icons.bolt_rounded, Goal.fullBody => Icons.accessibility_new_rounded };
}

class Exercise {
  const Exercise(this.name, this.area, this.sets, this.reps, this.seconds, this.icon, this.tip, this.needsEquipment);
  final String name, area, reps, tip;
  final int sets, seconds;
  final IconData icon;
  final bool needsEquipment;
}

const exercises = [
  Exercise('Kniebeugen', 'Beine & Gesäß', 3, '12 Wiederholungen', 40, Icons.accessibility_new_rounded, 'Knie folgen der Fußspitze. Gewicht auf den Fersen.', false),
  Exercise('Liegestütze', 'Brust & Trizeps', 3, '8–12 Wiederholungen', 35, Icons.front_hand_rounded, 'Halte den Körper wie ein Brett. Brust zwischen die Hände führen.', false),
  Exercise('Glute Bridge', 'Gesäß & Core', 3, '15 Wiederholungen', 35, Icons.keyboard_double_arrow_up_rounded, 'Drücke über die Fersen und spanne oben bewusst an.', false),
  Exercise('Rudern mit Band', 'Rücken & Bizeps', 3, '12 Wiederholungen', 40, Icons.rowing_rounded, 'Ziehe die Schulterblätter nach hinten unten.', true),
  Exercise('Plank', 'Core', 3, '30 Sekunden', 30, Icons.horizontal_rule_rounded, 'Bauchnabel sanft zur Wirbelsäule ziehen, Rücken neutral halten.', false),
  Exercise('Ausfallschritte', 'Beine & Balance', 3, '10 je Seite', 40, Icons.directions_walk_rounded, 'Großer Schritt zurück, vorderes Knie bleibt stabil.', false),
];

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;
  Goal goal = Goal.fullBody;
  final equipment = <String>{'Trainingsmatte'};

  @override
  Widget build(BuildContext context) {
    final pages = [HomePage(goal: goal, equipment: equipment, onStart: () => setState(() => index = 1)), WorkoutPlan(goal: goal, equipment: equipment), ProgressPage(goal: goal)];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: index, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Heute'),
          NavigationDestination(icon: Icon(Icons.play_circle_outline), selectedIcon: Icon(Icons.play_circle_rounded), label: 'Training'),
          NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights_rounded), label: 'Fortschritt'),
        ],
      ),
      floatingActionButton: index == 0
          ? FloatingActionButton.extended(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => SetupSheet(
                  goal: goal,
                  equipment: equipment,
                  onSave: (newGoal, newEquipment) => setState(() {
                    goal = newGoal;
                    equipment
                      ..clear()
                      ..addAll(newEquipment);
                  }),
                ),
              ),
              icon: const Icon(Icons.tune_rounded),
              label: const Text('Anpassen'),
            )
          : null,
    );
  }
}

class PagePadding extends StatelessWidget {
  const PagePadding({super.key, required this.child}); final Widget child;
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 8), child: child);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.goal, required this.equipment, required this.onStart});
  final Goal goal; final Set<String> equipment; final VoidCallback onStart;
  @override
  Widget build(BuildContext context) => PagePadding(child: ListView(children: [
    const Text('Guten Morgen,', style: TextStyle(fontSize: 17, color: AppColors.moss)),
    const Text('Bereit für dich?', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
    const SizedBox(height: 22),
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: AppColors.moss, borderRadius: BorderRadius.circular(28)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('DEIN TRAINING HEUTE', style: TextStyle(letterSpacing: 1.3, color: AppColors.mint, fontWeight: FontWeight.w700, fontSize: 12)),
      const SizedBox(height: 10), Text('${goal.label} Flow', style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700)),
      const SizedBox(height: 5), Text('30 Min · ${equipment.isEmpty ? 'Körpergewicht' : equipment.join(' · ')}', style: const TextStyle(color: Colors.white70)),
      const SizedBox(height: 22), FilledButton.icon(style: FilledButton.styleFrom(backgroundColor: AppColors.lime, foregroundColor: AppColors.ink), onPressed: onStart, icon: const Icon(Icons.play_arrow_rounded), label: const Text('Training ansehen')),
    ])),
    const SizedBox(height: 28), const Text('Dein Fokus', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    const SizedBox(height: 12), Wrap(spacing: 10, runSpacing: 10, children: Goal.values.map((item) => ChoiceChip(avatar: Icon(item.icon, size: 18), label: Text(item.label), selected: item == goal, onSelected: (_) {})).toList()),
    const SizedBox(height: 28), const Text('Kleine Schritte, echte Wirkung.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    const SizedBox(height: 10), const Text('Konstanz schlägt Perfektion. Deine Einheit ist bereits für dein Zuhause vorbereitet.'),
  ]));
}

class WorkoutPlan extends StatelessWidget {
  const WorkoutPlan({super.key, required this.goal, required this.equipment}); final Goal goal; final Set<String> equipment;
  List<Exercise> get plan => exercises.where((e) => !e.needsEquipment || equipment.contains('Widerstandsband')).take(5).toList();
  @override Widget build(BuildContext context) => PagePadding(child: ListView(children: [
    Text('${goal.label} Flow', style: Theme.of(context).textTheme.headlineLarge),
    const SizedBox(height: 6), Text('${plan.length} Übungen · ca. 30 Minuten', style: const TextStyle(color: AppColors.moss)),
    const SizedBox(height: 20),
    ...plan.asMap().entries.map((entry) => ExerciseCard(number: entry.key + 1, exercise: entry.value, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExerciseDetail(exercise: entry.value))))),
    const SizedBox(height: 10), FilledButton(style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 17)), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TrainingSession(plan: plan))), child: const Text('Training starten')),
  ]));
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.number, required this.exercise, required this.onTap}); final int number; final Exercise exercise; final VoidCallback onTap;
  @override Widget build(BuildContext context) => Card(color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), child: ListTile(onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), leading: CircleAvatar(backgroundColor: AppColors.mint, foregroundColor: AppColors.moss, child: Text('$number')), title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text('${exercise.sets} Sätze · ${exercise.reps}'), trailing: const Icon(Icons.chevron_right_rounded)));
}

class ExerciseDetail extends StatelessWidget {
  const ExerciseDetail({super.key, required this.exercise}); final Exercise exercise;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(backgroundColor: AppColors.cream), body: PagePadding(child: ListView(children: [
    AnimatedExercise(icon: exercise.icon), const SizedBox(height: 24), Text(exercise.name, style: Theme.of(context).textTheme.headlineLarge), const SizedBox(height: 5), Text(exercise.area, style: const TextStyle(color: AppColors.moss, fontWeight: FontWeight.w600)), const SizedBox(height: 20),
    const Text('So führst du sie aus', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)), const SizedBox(height: 8), Text(exercise.tip), const SizedBox(height: 20),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.lime.withOpacity(.45), borderRadius: BorderRadius.circular(18)), child: const Row(children: [Icon(Icons.lightbulb_outline_rounded), SizedBox(width: 10), Expanded(child: Text('Arbeite langsam und kontrolliert. Beende die Übung bei Schmerzen.'))])),
  ])));
}

class AnimatedExercise extends StatefulWidget { const AnimatedExercise({super.key, required this.icon}); final IconData icon; @override State<AnimatedExercise> createState() => _AnimatedExerciseState(); }
class _AnimatedExerciseState extends State<AnimatedExercise> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..repeat(reverse: true);
  @override void dispose() { controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Container(height: 250, decoration: BoxDecoration(color: AppColors.mint, borderRadius: BorderRadius.circular(30)), child: Center(child: AnimatedBuilder(animation: controller, builder: (_, child) => Transform.translate(offset: Offset(0, -18 * controller.value), child: child), child: Icon(widget.icon, size: 110, color: AppColors.moss))));
}

class TrainingSession extends StatefulWidget { const TrainingSession({super.key, required this.plan}); final List<Exercise> plan; @override State<TrainingSession> createState() => _TrainingSessionState(); }
class _TrainingSessionState extends State<TrainingSession> {
  int current = 0, seconds = 40; bool running = true; Timer? timer;
  @override void initState() { super.initState(); timer = Timer.periodic(const Duration(seconds: 1), (_) { if (running) setState(() { if (seconds > 0) seconds--; }); }); }
  @override void dispose() { timer?.cancel(); super.dispose(); }
  void next() { if (current < widget.plan.length - 1) setState(() { current++; seconds = widget.plan[current].seconds; }); else Navigator.pop(context); }
  @override Widget build(BuildContext context) { final e = widget.plan[current]; return Scaffold(body: SafeArea(child: PagePadding(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    LinearProgressIndicator(value: (current + 1) / widget.plan.length, color: AppColors.moss, backgroundColor: AppColors.sand), const SizedBox(height: 22), Text('Übung ${current + 1} von ${widget.plan.length}', style: const TextStyle(color: AppColors.moss)), const Spacer(), Center(child: AnimatedExercise(icon: e.icon)), const SizedBox(height: 30), Text(e.name, style: Theme.of(context).textTheme.headlineLarge), Text(e.reps, style: const TextStyle(fontSize: 17, color: AppColors.moss)), const SizedBox(height: 18), Center(child: Text('00:${seconds.toString().padLeft(2, '0')}', style: const TextStyle(fontSize: 58, fontWeight: FontWeight.w700))), const Spacer(), Row(children: [OutlinedButton(onPressed: () => setState(() => running = !running), child: Text(running ? 'Pause' : 'Weiter')), const SizedBox(width: 12), Expanded(child: FilledButton(onPressed: next, child: Text(current == widget.plan.length - 1 ? 'Abschließen' : 'Nächste Übung')))]),
  ])))); }
}

class ProgressPage extends StatelessWidget { const ProgressPage({super.key, required this.goal}); final Goal goal; @override Widget build(BuildContext context) => PagePadding(child: ListView(children: [Text('Dein Fortschritt', style: Theme.of(context).textTheme.headlineLarge), const SizedBox(height: 7), const Text('Jeder Einsatz zählt.'), const SizedBox(height: 24), const Row(children: [Metric(value: '4', label: 'Workouts\ndiese Woche'), SizedBox(width: 10), Metric(value: '120', label: 'Minuten\ntrainiert')]), const SizedBox(height: 24), Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.moss, borderRadius: BorderRadius.circular(24)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Wöchentliche Serie', style: TextStyle(color: Colors.white70)), SizedBox(height: 6), Text('3 Tage in Folge', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)), SizedBox(height: 16), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Day(label: 'M', active: true), Day(label: 'D', active: true), Day(label: 'M', active: true), Day(label: 'D'), Day(label: 'F'), Day(label: 'S'), Day(label: 'S')])])), const SizedBox(height: 25), Text('Aktuelles Ziel: ${goal.label}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))])); }
}
class Metric extends StatelessWidget { const Metric({super.key, required this.value, required this.label}); final String value, label; @override Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)), Text(label, style: const TextStyle(color: AppColors.moss))]))); }
class Day extends StatelessWidget { const Day({super.key, required this.label, this.active = false}); final String label; final bool active; @override Widget build(BuildContext context) => CircleAvatar(radius: 16, backgroundColor: active ? AppColors.lime : Colors.white24, foregroundColor: active ? AppColors.ink : Colors.white, child: Text(label)); }

class SetupSheet extends StatefulWidget { const SetupSheet({super.key, required this.goal, required this.equipment, required this.onSave}); final Goal goal; final Set<String> equipment; final void Function(Goal, Set<String>) onSave; @override State<SetupSheet> createState() => _SetupSheetState(); }
class _SetupSheetState extends State<SetupSheet> { late Goal selected = widget.goal; late Set<String> selectedEquipment = {...widget.equipment}; final options = const ['Trainingsmatte', 'Hanteln', 'Widerstandsband', 'Kettlebell', 'Klimmzugstange', 'Stuhl']; @override Widget build(BuildContext context) => DraggableScrollableSheet(initialChildSize: .78, maxChildSize: .92, builder: (_, scroll) => Container(decoration: const BoxDecoration(color: AppColors.cream, borderRadius: BorderRadius.vertical(top: Radius.circular(30))), child: ListView(controller: scroll, padding: const EdgeInsets.all(22), children: [const Center(child: SizedBox(width: 38, child: Divider(thickness: 4))), const SizedBox(height: 18), const Text('Dein Setup', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)), const SizedBox(height: 22), const Text('Worauf möchtest du dich konzentrieren?', style: TextStyle(fontWeight: FontWeight.w700)), Wrap(spacing: 8, children: Goal.values.map((g) => ChoiceChip(label: Text(g.label), selected: g == selected, onSelected: (_) => setState(() => selected = g))).toList()), const SizedBox(height: 24), const Text('Was steht dir zur Verfügung?', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 8), Wrap(spacing: 8, runSpacing: 8, children: options.map((item) => FilterChip(label: Text(item), selected: selectedEquipment.contains(item), onSelected: (on) => setState(() { on ? selectedEquipment.add(item) : selectedEquipment.remove(item); }))).toList()), const SizedBox(height: 30), FilledButton(onPressed: () { widget.onSave(selected, selectedEquipment); Navigator.pop(context); }, child: const Text('Workout aktualisieren'))]))); }
}
