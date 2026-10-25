import 'package:flutter/material.dart';

import '../invoicing/enums.dart';
import '../theme/app_theme.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.bottom,
    this.fab,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? bottom;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: body,
      floatingActionButton: fab,
      bottomNavigationBar: bottom == null
          ? null
          : SafeArea(
              child: Padding(padding: const EdgeInsets.fromLTRB(20, 8, 20, 12), child: bottom),
            ),
    );
  }
}

class InvoxaCard extends StatelessWidget {
  const InvoxaCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.onTap});

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: dark ? InvoxaColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: dark
            ? null
            : const [BoxShadow(color: Color(0x141B2A4A), blurRadius: 18, offset: Offset(0, 8))],
      ),
      child: child,
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(20), child: card),
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final InvoiceStatus status;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(status, Theme.of(context).brightness);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text(
        status.label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.title, required this.body, this.action, this.onAction, this.icon});

  final String title;
  final String body;
  final String? action;
  final VoidCallback? onAction;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).brightness == Brightness.dark ? InvoxaColors.darkMuted : InvoxaColors.muted;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.inbox_outlined, size: 42, color: muted),
            const SizedBox(height: 16),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(body, textAlign: TextAlign.center, style: TextStyle(color: muted, height: 1.4)),
            if (action != null && onAction != null) ...[
              const SizedBox(height: 20),
              FilledButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}

class InvoxaField extends StatelessWidget {
  const InvoxaField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(labelText: label, hintText: hint),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()));
  }
}

Future<bool> confirmAction(
  BuildContext context, {
  required String title,
  required String body,
  required String confirm,
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Back')),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirm, style: TextStyle(color: destructive ? InvoxaColors.overdue : null)),
        ),
      ],
    ),
  );
  return result ?? false;
}

void showNotice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Color? parseHex(String value) {
  final match = RegExp(r'^#([0-9A-Fa-f]{6})$').firstMatch(value.trim());
  if (match == null) return null;
  return Color(int.parse('FF${match.group(1)}', radix: 16));
}

String minorInput(int minor) {
  final whole = minor ~/ 100;
  final fraction = minor % 100;
  if (fraction == 0) return '$whole';
  return '$whole.${fraction.toString().padLeft(2, '0')}';
}
