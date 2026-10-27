import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/progress/presentation/progress_screen.dart';
import '../features/profile/presentation/setup_sheet.dart';
import '../features/workouts/presentation/home_dashboard.dart';
import '../features/workouts/presentation/workout_plan_screen.dart';
import 'homefit_controller.dart';

class HomeFitApp extends StatefulWidget {
  const HomeFitApp({super.key});
  @override
  State<HomeFitApp> createState() => _HomeFitAppState();
}

class _HomeFitAppState extends State<HomeFitApp> {
  late final HomeFitController controller = HomeFitController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'HomeFit',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => _HomeShell(controller: controller),
        ),
      );
}

class _HomeShell extends StatelessWidget {
  const _HomeShell({required this.controller});
  final HomeFitController controller;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeDashboard(controller: controller),
      WorkoutPlanScreen(controller: controller),
      ProgressScreen(controller: controller),
    ];
    return Scaffold(
      body: IndexedStack(index: controller.navigationIndex, children: pages),
      floatingActionButton: controller.navigationIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => SetupSheet(controller: controller),
              ),
              backgroundColor: AppColors.forest,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.tune_rounded),
              label: const Text('Plan anpassen'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: controller.navigationIndex,
        onDestinationSelected: controller.selectNavigation,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Heute'),
          NavigationDestination(
              icon: Icon(Icons.play_circle_outline),
              selectedIcon: Icon(Icons.play_circle_rounded),
              label: 'Training'),
          NavigationDestination(
              icon: Icon(Icons.insights_outlined),
              selectedIcon: Icon(Icons.insights_rounded),
              label: 'Fortschritt'),
        ],
      ),
    );
  }
}
