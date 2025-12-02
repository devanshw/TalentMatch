import 'package:flutter/material.dart';
import 'package:talent_match/l10n/app_localizations.dart';
import '../models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  final VoidCallback? firstButtonCallback;
  final String? firstButtonLabel;
  final IconData? firstButtonIcon;
  final Color? firstButtonColor;
  final VoidCallback? secondButtonCallback;
  final String? secondButtonLabel;
  final IconData? secondButtonIcon;
  final Color? secondButtonColor;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    this.firstButtonCallback,
    this.firstButtonLabel,
    this.firstButtonIcon,
    this.firstButtonColor,
    this.secondButtonCallback,
    this.secondButtonLabel,
    this.secondButtonIcon,
    this.secondButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<Widget> buttons = [];

    if (firstButtonCallback != null) {
      buttons.add(
        Expanded(
          child: ElevatedButton.icon(
            onPressed: firstButtonCallback,
            icon: Icon(firstButtonIcon ?? Icons.check),
            label: Text(firstButtonLabel ?? l10n.button),
            style: ElevatedButton.styleFrom(
              backgroundColor: firstButtonColor ?? Colors.green,
            ),
          ),
        ),
      );
    }

    if (secondButtonCallback != null && buttons.isNotEmpty) {
      buttons.add(const SizedBox(width: 12));
    }

    if (secondButtonCallback != null) {
      buttons.add(
        Expanded(
          child: ElevatedButton.icon(
            onPressed: secondButtonCallback,
            icon: Icon(secondButtonIcon ?? Icons.close),
            label: Text(secondButtonLabel ?? l10n.button),
            style: ElevatedButton.styleFrom(
              backgroundColor: secondButtonColor ?? Colors.red,
            ),
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  job.logo != null
                      ? Image.network(
                          job.logo!,
                          width: 40,
                          height: 40,
                        )
                      : const Icon(Icons.work, size: 40),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                job.employer,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.relevance(job.relevance),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (buttons.isNotEmpty) Row(children: buttons),
            ],
          ),
        ),
      ),
    );
  }
}