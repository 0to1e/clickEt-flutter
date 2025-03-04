import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text; // Text to be displayed on the button
  final VoidCallback onPressed; // Callback for button press
  final Color? backgroundColor; // Button background color
  final Color? textColor; // Text color
  final dynamic width; // Button width (double value or 'full')
  final dynamic height; // Button height (double value or 'full')
  final Icon? icon; // Optional icon for the button
  final bool iconBeforeText; // Controls if the icon should be before the text
  final bool iconAfterText; // Controls if the icon should be after the text
  final EdgeInsetsGeometry? margin; // Margin for the content
  final double? radius; // Border radius for button
  final double? fontSize;
  // Constructor
  const Button({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 20,
    this.width = 'full', // Default to full width
    this.height = 50.0, // Default height to 50
    this.radius,
    this.icon,
    this.iconBeforeText = false, // Default to icon being after text
    this.iconAfterText = false, // Default to icon being after text
    this.margin, // Margin is now used instead of padding
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Width logic: if 'full', use full width, otherwise use the provided width
    double buttonWidth =
        (width == 'full') ? double.infinity : (width is double ? width : 200.0);

    // Height logic: if 'full', use full height, otherwise use the provided height
    double buttonHeight = (height == 'full')
        ? MediaQuery.of(context).size.height
        : (height is double ? height : 50.0);

    // Adjust the width if margin is provided (apply margin horizontally)
    if (margin != null) {
      // If margin is provided, subtract horizontal margin from the button width
      buttonWidth = (width == 'full')
          ? double.infinity // If width is 'full', margin won't affect it.
          : (width is double ? width - (margin?.horizontal ?? 0.0) : 200.0);
    }

    // Build the row with icon and text based on icon placement logic
    List<Widget> buttonContent = [];

    if (icon != null && iconBeforeText) {
      buttonContent.add(icon!);
      buttonContent
          .add(const SizedBox(width: 8)); // Space between icon and text
    }

    buttonContent.add(
      Text(
        text,
        style: GoogleFonts.lexend(
            color: textColor ??
                Colors.white, // Use textColor if provided, else white
            fontSize: fontSize,
            fontWeight: FontWeight.w500),
      ),
    );

    if (icon != null && iconAfterText) {
      buttonContent
          .add(const SizedBox(width: 8)); // Space between text and icon
      buttonContent.add(icon!);
    }

    return GestureDetector(
      onTap: onPressed, // Trigger the onPressed callback
      child: Container(
        width: buttonWidth, // Set width of the button
        height: buttonHeight, // Set height of the button
        margin: margin ?? EdgeInsets.zero, // Apply margin if provided
        decoration: BoxDecoration(
          gradient: backgroundColor == null
              ? LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null, // Use gradient if no backgroundColor is provided
          color: backgroundColor, // Use solid background color if provided
          borderRadius: BorderRadius.circular(radius ?? 5), // Rounded corners
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonContent,
          ),
        ),
      ),
    );
  }
}
