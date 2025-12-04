import 'package:flutter/material.dart';
import '../models/job.dart';
import '../theme/app_theme.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  // First (left) button
  final VoidCallback? firstButtonCallback;
  final String? firstButtonLabel;
  final IconData? firstButtonIcon;
  final Color? firstButtonColor;

  // Second (right) button
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
    final List<Widget> buttons = [];

    // First button
    if (firstButtonCallback != null) {
      buttons.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppTheme.buttonRadius,
              boxShadow: [
                BoxShadow(
                  color: (firstButtonColor ?? AppTheme.successGreen).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: firstButtonCallback,
              icon: Icon(firstButtonIcon ?? Icons.check, size: 18),
              label: Text(firstButtonLabel ?? "Button"),
              style: ElevatedButton.styleFrom(
                backgroundColor: firstButtonColor ?? AppTheme.successGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.buttonRadius,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Spacer if both buttons exist
    if (secondButtonCallback != null && buttons.isNotEmpty) {
      buttons.add(const SizedBox(width: 12));
    }

    // Second button
    if (secondButtonCallback != null) {
      buttons.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppTheme.buttonRadius,
              boxShadow: [
                BoxShadow(
                  color: (secondButtonColor ?? AppTheme.errorRed).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: secondButtonCallback,
              icon: Icon(secondButtonIcon ?? Icons.close, size: 18),
              label: Text(secondButtonLabel ?? "Button"),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondButtonColor ?? AppTheme.errorRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.buttonRadius,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: AppTheme.cardRadius,
        boxShadow: AppTheme.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppTheme.cardRadius,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo + Title Row
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.lightBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: job.logo != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                job.logo!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.work, 
                                      color: AppTheme.primaryBlue, size: 28),
                              ),
                            )
                          : const Icon(Icons.work, 
                              color: AppTheme.primaryBlue, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job.employer,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Relevance Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: AppTheme.chipRadius,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        "${job.relevance}% Match",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Buttons row
                if (buttons.isNotEmpty) Row(children: buttons),
              ],
            ),
          ),
        ),
      ),
    );
  }
}