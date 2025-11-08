import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../data/provider/theme_provider.dart';
import '../../../../domain/models/item_model.dart';


class ItemTile extends StatelessWidget {
  final ItemModel item;

  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final created = DateFormat.yMMMd().add_jm().format(item.createdAt);

    final isDark = themeProvider.isDark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? ZohColors.darkGrey : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Light mode shadow
          if (!isDark)
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          // Dark mode shadow (subtle to show depth)
          if (isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          if (isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, -1),
              spreadRadius: 0.5,
            ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(
          item.title,
          style: GoogleFonts.viga(
            fontSize: ZohSizes.spaceBtwZoh,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.black : ZohColors.darkColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.notes != null && item.notes!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 6),
                child: Text(
                  item.notes!,
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.black87 : ZohColors.darkColor,
                    fontSize: ZohSizes.spaceBtwZoh,
                  ),
                ),
              ),
            Text(
              created,
              style: TextStyle(
                fontSize: ZohSizes.iconXs,
                color: isDark ? Colors.black87 : ZohColors.darkColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: isDark ? Colors.black45 : ZohColors.darkColor,
          size: ZohSizes.spaceBtwSections,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
