import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final bool isEnabled;
  final double? width;
  final double? radius;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomDropdown({
    required this.hint,
    this.value,
    this.items,
    this.onChanged,
    this.isEnabled = true,
    this.width,
    this.radius,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dropdownBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary.withOpacity(0.8);

    // Define text style once to reuse
    final textStyle = GoogleFonts.lexend(
      color: textColor ?? Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: backgroundColor == null
            ? LinearGradient(
                colors: [
                  theme.colorScheme.primary.withAlpha(80),
                  theme.colorScheme.secondary.withAlpha(80),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius ?? 5),
      ),
      child: Theme(
        // Override the default dropdown theme
        data: Theme.of(context).copyWith(
          canvasColor:
              dropdownBackgroundColor, // Background color of the dropdown menu
          // Disable the splash effect
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ButtonTheme(
          alignedDropdown: true, // Aligns the dropdown menu with the button
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<T>(
                value: value,
                hint: Text(hint, style: textStyle),
                icon:
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                iconSize: 24,
                elevation: 8,
                style: textStyle,
                isExpanded: true,
                onChanged: isEnabled ? onChanged : null,
                items: items?.map((item) {
                  // Apply our style to each dropdown item
                  return DropdownMenuItem<T>(
                    value: item.value,
                    child: DefaultTextStyle(
                      style: textStyle,
                      child: item.child,
                    ),
                  );
                }).toList(),
                // Make sure the dropdown opens below
                menuMaxHeight: 300,
                dropdownColor: dropdownBackgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
