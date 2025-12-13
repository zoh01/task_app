import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../data/provider/theme_provider.dart';

Future<bool?> showDeleteDialog(BuildContext context) {
  final themeProvider = context.read<ThemeProvider>();
  final isDark = themeProvider.isDark;

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: isDark ? ZohColors.darkerGrey : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.redAccent.shade200, size: 27),
          const SizedBox(width: 10),
          const Text(
            'Delete Task?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to delete this task? This action cannot be undone.',
        style: TextStyle(
          fontSize: ZohSizes.md,
          fontFamily: 'Poppins',
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text(
            'Delete',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}