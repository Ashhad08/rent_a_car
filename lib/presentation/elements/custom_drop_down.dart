import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/extensions.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.label,
    required this.dropdownMenuEntries,
    required this.onSelected,
    required this.enabled,
    this.isDense = false,
    required this.initialItem,
    this.errorMessageIfRequired,
    this.prefixIcon,
    this.suffix,
  });

  final String label;
  final bool enabled;
  final String? errorMessageIfRequired;
  final List<MapEntry<String, String>> dropdownMenuEntries;
  final Function(MapEntry<String, String>?) onSelected;
  final MapEntry<String, String>? initialItem;
  final bool isDense;
  final Widget? prefixIcon;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final sortedEntries = dropdownMenuEntries.toSet().toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    final dropdownItems = sortedEntries.map((entry) {
      return DropdownMenuItem<String>(
        value: entry.key,
        child: Text(
          entry.value,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList();

    return DropdownButtonFormField2<String>(
      isExpanded: true,
      onChanged: (value) {
        if (value != null) {
          final selectedEntry = sortedEntries.firstWhere(
            (entry) => entry.key == value,
            orElse: () => MapEntry("", ""),
          );
          onSelected(selectedEntry);
        }
      },
      value: enabled ? initialItem?.key : null,
      hint: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      decoration: InputDecoration(
        enabled: enabled,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colorScheme.outline.withOp(0.1),
          ),
        ),
        isDense: isDense,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colorScheme.outline.withOp(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colorScheme.outline.withOp(0.3),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colorScheme.error,
          ),
        ),
        filled: true,
        prefixIconColor: context.colorScheme.outline.withOp(0.8),
        fillColor: context.colorScheme.onPrimary,
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(14.0),
                child: prefixIcon,
              ),
        suffixIcon: suffix,
      ),
      items: dropdownItems,
      validator: (value) {
        if (errorMessageIfRequired != null &&
            !sortedEntries.any((entry) => entry.key == value)) {
          return errorMessageIfRequired;
        }
        return null;
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded),
        icon: Icon(Icons.keyboard_arrow_down_rounded),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        useSafeArea: true,
        maxHeight: context.screenHeight * 0.6,
        isOverButton: false,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(context.colorScheme.outline),
          radius: const Radius.circular(4),
          thickness: WidgetStateProperty.all(4),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.onPrimary,
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
