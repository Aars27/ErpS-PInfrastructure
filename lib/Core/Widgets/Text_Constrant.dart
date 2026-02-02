import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// App Color Palette
class AppColors {
  // Primary Orange Colors
  static const Color primaryOrange = Color(0xFFFF6B35);
  static const Color lightOrange = Color(0xFFFF8C5A);
  static const Color darkOrange = Color(0xFFE85A2A);
  static const Color paleOrange = Color(0xFFFFF3EF);

  // Secondary Colors
  static const Color secondaryBlue = Color(0xFF4A90E2);
  static const Color secondaryGreen = Color(0xFF4CAF50);
  static const Color secondaryPurple = Color(0xFF9C27B0);

  // Gradient Colors
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF8C5A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkOrangeGradient = LinearGradient(
    colors: [Color(0xFFE85A2A), Color(0xFFFF6B35)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Mixed Gradients
  static const LinearGradient orangeBlueGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFF4A90E2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangePurpleGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFF9C27B0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Neutral Colors
  static const Color darkText = Color(0xFF2D3748);
  static const Color mediumText = Color(0xFF4A5568);
  static const Color lightText = Color(0xFF718096);
  static const Color greyText = Color(0xFFA0AEC0);

  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFFAFBFC);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
}

// App Text Styles (Google Fonts - Most Popular)
class AppTextStyles {
  // Display Styles (Large headers) - Using Poppins
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
    letterSpacing: -0.3,
    height: 1.2,
  );

  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
    height: 1.3,
  );

  // Headline Styles (Section headers) - Using Poppins
  static TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    height: 1.3,
  );

  static TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    height: 1.3,
  );

  static TextStyle headlineSmall = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    height: 1.4,
  );

  // Title Styles (Card titles, list titles) - Using Inter
  static TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    letterSpacing: 0.15,
    height: 1.4,
  );

  static TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    letterSpacing: 0.15,
    height: 1.4,
  );

  static TextStyle titleSmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // Body Styles (Main content) - Using Inter
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumText,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumText,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumText,
    letterSpacing: 0.4,
    height: 1.5,
  );

  // Label Styles (Buttons, chips, small labels) - Using Roboto
  static TextStyle labelLarge = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    letterSpacing: 0.5,
  );

  static TextStyle labelMedium = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.lightText,
    letterSpacing: 0.5,
  );

  // Button Styles - Using Poppins
  static TextStyle buttonLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle buttonMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static TextStyle buttonSmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Special Styles
  static TextStyle caption = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lightText,
    letterSpacing: 0.4,
    height: 1.4,
  );

  static TextStyle overline = GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.lightText,
    letterSpacing: 1.5,
  );

  // Custom Orange Styles - Using Poppins
  static TextStyle orangeTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryOrange,
    height: 1.3,
  );

  static TextStyle orangeBody = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryOrange,
    height: 1.5,
  );

  static TextStyle orangeButton = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // Gradient Text Helper (Use with Shader)
  static TextStyle gradientText({
    required double fontSize,
    required FontWeight fontWeight,
    required Gradient gradient,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      foreground: Paint()
        ..shader = gradient.createShader(
          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
        ),
    );
  }
}

// Widget Extension for Gradient Text
class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    required this.gradient,
    required this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.white,
        ),
        textAlign: textAlign,
      ),
    );
  }
}

// Quick Text Widgets (Most Used)
class AppText {
  // Heading
  static Widget h1(String text, {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: AppTextStyles.displayLarge.copyWith(color: color),
      textAlign: align,
    );
  }

  static Widget h2(String text, {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: AppTextStyles.displayMedium.copyWith(color: color),
      textAlign: align,
    );
  }

  static Widget h3(String text, {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: AppTextStyles.headlineLarge.copyWith(color: color),
      textAlign: align,
    );
  }

  static Widget h4(String text, {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: AppTextStyles.headlineMedium.copyWith(color: color),
      textAlign: align,
    );
  }

  // Titles
  static Widget title(String text, {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: AppTextStyles.titleLarge.copyWith(color: color),
      textAlign: align,
    );
  }

  static Widget titleSmall(String text, {Color? color, TextAlign? align}) {
    return Text(
      text,
      style: AppTextStyles.titleSmall.copyWith(color: color),
      textAlign: align,
    );
  }

  // Body
  static Widget body(String text, {Color? color, TextAlign? align, int? maxLines}) {
    return Text(
      text,
      style: AppTextStyles.bodyLarge.copyWith(color: color),
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  static Widget bodySmall(String text, {Color? color, TextAlign? align, int? maxLines}) {
    return Text(
      text,
      style: AppTextStyles.bodySmall.copyWith(color: color),
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  // Labels
  static Widget label(String text, {Color? color}) {
    return Text(
      text,
      style: AppTextStyles.labelMedium.copyWith(color: color),
    );
  }

  static Widget caption(String text, {Color? color}) {
    return Text(
      text,
      style: AppTextStyles.caption.copyWith(color: color),
    );
  }

  // Button Text
  static Widget button(String text, {Color? color}) {
    return Text(
      text,
      style: AppTextStyles.buttonMedium.copyWith(color: color ?? Colors.white),
    );
  }

  // Orange Styled
  static Widget orangeTitle(String text) {
    return Text(text, style: AppTextStyles.orangeTitle);
  }

  static Widget orangeBody(String text) {
    return Text(text, style: AppTextStyles.orangeBody);
  }

  // Gradient Text
  static Widget gradient(
      String text, {
        required Gradient gradient,
        double fontSize = 24,
        FontWeight fontWeight = FontWeight.bold,
      }) {
    return GradientText(
      text: text,
      gradient: gradient,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}