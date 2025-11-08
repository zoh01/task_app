import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:task/features/presentation/screens/home_screen/widgets/delete_dialog.dart';
import 'package:task/features/presentation/screens/home_screen/widgets/item_tile.dart';
import 'package:task/utils/constants/colors.dart';
import 'package:task/utils/constants/image_strings.dart';
import 'package:task/utils/constants/sizes.dart';
import 'package:task/utils/constants/text_strings.dart';
import '../../../data/provider/item_provider.dart';
import '../../../data/provider/theme_provider.dart';
import '../add_edit_screen/add_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = context.watch<ItemProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? ZohColors.darkerGrey
          : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDark
            ? ZohColors.black
            : ZohColors.grey,
        centerTitle: true,
        title: Text(
          'Tasks',
          style: GoogleFonts.breeSerif(
            fontWeight: FontWeight.bold,
            fontSize: ZohSizes.defaultSpace,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: FlutterSwitch(
              width: 70.0,
              height: 35.0,
              toggleSize: 30.0,
              value: themeProvider.isDark,
              activeColor: ZohColors.darkerGrey,
              inactiveColor: ZohColors.darkGrey,
              activeIcon: const Icon(
                Icons.nightlight_round,
                color: Colors.black,
              ),
              inactiveIcon: const Icon(Icons.wb_sunny, color: Colors.black),
              borderRadius: 20.0,
              onToggle: (val) => context.read<ThemeProvider>().toggleTheme(),
            ),
          ),
        ],
      ),
      body: itemProvider.items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(ZohSizes.spaceBtwSections),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceInDown(
                      child: Image(
                        image: AssetImage(ZohImageStrings.emptyBasket),
                        width: MediaQuery.of(context).size.width * .6,
                      ),
                    ),
                    FadeInUp(
                      child: Text(
                        ZohTextString.empty,
                        style: GoogleFonts.anton(
                          fontSize: ZohSizes.spaceBtwZoh,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDark
                              ? ZohColors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: ZohSizes.iconXs),
                    FadeInUp(
                      child: Text(
                        ZohTextString.emptyDesc,
                        style: GoogleFonts.archivo(
                          fontSize: ZohSizes.spaceBtwZoh,
                          color: themeProvider.isDark
                              ? ZohColors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
                final item = itemProvider.items[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: const BorderRadius.all(Radius.circular(ZohSizes.md)),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    final shouldDelete = await showDeleteDialog(context);
                    if (shouldDelete == true) {
                      await itemProvider.deleteItem(item.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task deleted successfully!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return true;
                    }
                    return false;
                  },
                  onDismissed: (_) =>
                      context.read<ItemProvider>().deleteItem(item.id),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AddEditScreen(item: item),
                        ),
                      );
                    },
                    child: ItemTile(item: item),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeProvider.isDark
            ? ZohColors.secondaryColor
            : ZohColors.secondaryColor,
        onPressed: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context) => AddEditScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: ZohSizes.spaceBtwSections,
        ),
      ),
    );
  }
}
