import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../data/provider/item_provider.dart';
import '../../../data/provider/theme_provider.dart';
import '../../../domain/models/item_model.dart';

class AddEditScreen extends StatefulWidget {
  final ItemModel? item;

  const AddEditScreen({super.key, this.item});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title ?? '');
    _notesController = TextEditingController(text: widget.item?.notes ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final notes = _notesController.text.trim().isEmpty
        ? null
        : _notesController.text.trim();

    final provider = context.read<ItemProvider>();
    final themeProvider = context.read<ThemeProvider>();
    final isEditing = widget.item != null;

    try {
      if (isEditing) {
        await provider.updateItem(
          id: widget.item!.id,
          title: title,
          notes: notes,
        );
      } else {
        await provider.addItem(title: title, notes: notes);
      }

      if (!mounted) return;

      /// Show success snackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'Task updated successfully!'
                : 'Task added successfully!',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: themeProvider.isDark ? Colors.black : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: themeProvider.isDark ? Colors.white : Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;

      // Show error snackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong. Please try again.',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: themeProvider.isDark ? Colors.black : Colors.white,
            ),
          ),
          backgroundColor: themeProvider.isDark
              ? Colors.white
              : Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isEditing = widget.item != null;
    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? ZohColors.darkerGrey
          : ZohColors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDark
            ? ZohColors.black
            : ZohColors.grey,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          isEditing ? 'Edit Task' : 'Add Task',
          style: GoogleFonts.breeSerif(
            fontWeight: FontWeight.bold,
            fontSize: ZohSizes.defaultSpace,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Title",
                style: GoogleFonts.viga(
                  fontSize: ZohSizes.defaultSpace,
                  fontWeight: FontWeight.normal,
                  color: themeProvider.isDark ? Colors.white : Colors.black,
                ),
              ),
              TextFormField(
                controller: _titleController,
                cursorColor: themeProvider.isDark ? Colors.white : Colors.black,
                keyboardType: TextInputType.name,
                maxLines: 1,
                style: GoogleFonts.viga(
                  fontSize: ZohSizes.spaceBtwZoh,
                  fontWeight: FontWeight.normal,
                  color: themeProvider.isDark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: themeProvider.isDark
                      ? ZohColors.darkerGrey
                      : Colors.grey,
                  hintText: "Title",
                  hintStyle: GoogleFonts.viga(
                    fontSize: ZohSizes.spaceBtwZoh,
                    fontWeight: FontWeight.normal,
                    color: themeProvider.isDark ? Colors.white : Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeProvider.isDark
                          ? ZohColors.bgColor
                          : ZohColors.black,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ZohColors.darkColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter a title'
                    : null,
              ),
              const SizedBox(height: ZohSizes.spaceBtwItems),
              Text(
                "Description",
                style: GoogleFonts.viga(
                  fontSize: ZohSizes.defaultSpace,
                  fontWeight: FontWeight.normal,
                  color: themeProvider.isDark ? Colors.white : Colors.black,
                ),
              ),
              TextFormField(
                controller: _notesController,

                cursorColor: themeProvider.isDark ? Colors.white : Colors.black,
                keyboardType: TextInputType.name,
                maxLines: 3,
                style: GoogleFonts.viga(
                  fontSize: ZohSizes.spaceBtwZoh,
                  fontWeight: FontWeight.normal,
                  color: themeProvider.isDark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: themeProvider.isDark
                      ? ZohColors.darkerGrey
                      : Colors.grey,
                  hintText: "Title",
                  hintStyle: GoogleFonts.viga(
                    fontSize: ZohSizes.spaceBtwZoh,
                    fontWeight: FontWeight.normal,
                    color: themeProvider.isDark ? Colors.white : Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeProvider.isDark
                          ? ZohColors.bgColor
                          : ZohColors.black,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ZohColors.darkColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),

              SizedBox(height: ZohSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ZohColors.secondaryColor,
                    minimumSize: const Size(0, 60),
                    side: const BorderSide(color: ZohColors.secondaryColor),
                    elevation: 5,
                  ),
                  child: Text(
                    isEditing ? "Save changes" : "Add task",
                    style: GoogleFonts.viga(
                      fontSize: ZohSizes.spaceBtwZoh,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
