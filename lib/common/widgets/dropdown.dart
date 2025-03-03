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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<T>(
        value: value,
        hint: Text(
          hint,
          style: GoogleFonts.lexend(
            color: textColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        iconSize: 24,
        elevation: 16,
        style: GoogleFonts.lexend(
          color: textColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: theme.colorScheme.primary.withAlpha(90),
        underline: Container(),
        isExpanded: true,
        onChanged: isEnabled ? onChanged : null,
        items: items,
      ),
    );
  }
}
