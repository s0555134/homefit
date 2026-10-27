import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key, required this.child, this.padding = true});
  final Widget child;
  final bool padding;

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: padding
            ? Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpace.page, AppSpace.lg, AppSpace.page, AppSpace.md),
                child: child)
            : child,
      );
}

class AppCard extends StatelessWidget {
  const AppCard(
      {super.key,
      required this.child,
      this.color,
      this.padding = const EdgeInsets.all(AppSpace.md)});
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => Container(
      padding: padding,
      decoration: BoxDecoration(
          color: color ?? AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(
              color: color == null ? AppColors.line : Colors.transparent)),
      child: child);
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(
      {super.key, required this.title, this.action, this.actionLabel});
  final String title;
  final VoidCallback? action;
  final String? actionLabel;
  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
        if (action != null)
          TextButton(onPressed: action, child: Text(actionLabel ?? 'Alle'))
      ]);
}

class Pill extends StatelessWidget {
  const Pill({super.key, required this.label, this.dark = false});
  final String label;
  final bool dark;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.sm, vertical: 6),
      decoration: BoxDecoration(
          color: dark
              ? Colors.white.withValues(alpha: .16)
              : AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(100)),
      child: Text(label,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: dark ? Colors.white : AppColors.forest)));
}

class MetricTile extends StatelessWidget {
  const MetricTile(
      {super.key,
      required this.value,
      required this.label,
      required this.icon});
  final String value;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => AppCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: AppColors.forest, size: 20),
        const SizedBox(height: AppSpace.md),
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppSpace.xxs),
        Text(label, style: Theme.of(context).textTheme.bodyMedium)
      ]));
}
