import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quizy/app_theme/app_colors.dart';

class RestorePurchaseDialog extends StatefulWidget {
  const RestorePurchaseDialog({super.key});

  @override
  State<RestorePurchaseDialog> createState() => _RestorePurchaseDialogState();
}

class _RestorePurchaseDialogState extends State<RestorePurchaseDialog> {
  bool isRestored = false;

  @override
  void initState() {
    super.initState();

    // Simulate restore process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isRestored = true;
      });

      // Auto-close after showing success
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isRestored) ...[
              LoadingAnimationWidget.inkDrop(
                color: Colors.amber,
                size: 50,
              ),
              const SizedBox(height: 20),

              const Text(
                'Restoring Purchase',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              const Text(
                'Please wait while we restore your purchase.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              // Success State
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green, width: 3),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.check,
                  color: AppColors.green,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Purchase restored",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
