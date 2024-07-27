import 'package:flutter/material.dart';

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color? primary;
  final Color? primaryVariant;
  final Color? secondary;
  final Color? secondaryVariant;
  final Color? background;
  final Color? surface;
  final Color? error;
  final Color? onPrimary;
  final Color? onSecondary;
  final Color? onBackground;
  final Color? onSurface;
  final Color? onError;
  final Color? bottomNavigationBarColor;
  final Color? homeHeaderColor;
  final Color? homeBackgroundColor;

  final Color? ffC5CBC6; // New color property
  final Color? ffDDA815; // New color property
  final Color? ff8D8B8B; // New color property
  final Color? ff252525; // New color property
  final Color? ffBDA386; // New color property
  final Color? ffF5F5F5; // New color property
  final Color? ffbfa56d; // New color property
  final Color? ff5C5869; // New color property
  final Color? ff535B70; // New color property

  AppThemeColors({
    this.primary = const Color(0xffbfa46d),
    this.primaryVariant = const Color(0xFF3700B3),
    this.secondary = const Color(0xFF03DAC6),
    this.secondaryVariant = const Color(0xFF018786),
    this.background = const Color(0xFFFFFFFF),
    this.surface = const Color(0xFFFFFFFF),
    this.error = const Color(0xFFB00020),
    this.onPrimary = const Color(0xFFFFFFFF),
    this.onSecondary = const Color(0xFF000000),
    this.onBackground = const Color(0xFF000000),
    this.onSurface = const Color(0xFF000000),
    this.onError = const Color(0xFFFFFFFF),
    this.bottomNavigationBarColor = const Color(0xffC5CBC6),
    this.homeHeaderColor = const Color(0xffC5CBC6), // New color property
    this.homeBackgroundColor = const Color(0xFFFFFFFF),
    this.ffC5CBC6 = const Color(0xffC5CBC6), // New color property
    this.ffDDA815 = const Color(0xffDDA815), // New color property
    this.ff8D8B8B = const Color(0xff8B8B8B), // New color property
    this.ff252525 = const Color(0xff252525), // New color property
    this.ffBDA386 = const Color(0xffBDA386), // New color property
    this.ffF5F5F5 = const Color(0xffF5F5F5), // New color property
    this.ffbfa56d = const Color(0xffbfa56d), // New color property
    this.ff5C5869 = const Color(0xff5C5869), // New color property
    this.ff535B70 = const Color(0xff535B70), // New color property
  });

  @override
  AppThemeColors copyWith({
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? secondaryVariant,
    Color? background,
    Color? surface,
    Color? error,
    Color? onPrimary,
    Color? onSecondary,
    Color? onBackground,
    Color? onSurface,
    Color? onError,
    Color? bottomNavigationBarColor,
    Color? homeHeaderColor, // New color property
    Color? homeBackgroundColor,

    Color? ffC5CBC6, // New color property
    Color? ffDDA815, // New color property
    Color? ff8D8B8B, // New color property
    Color? ff252525, // New color property
    Color? ffBDA386, // New color property
    Color? ffF5F5F5, // New color property
    Color? ffbfa56d, // New color property
    Color? ff5C5869, // New color property
    Color? ff535B70, // New color property
  }) {
    return AppThemeColors(
      primary: primary ?? this.primary,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      secondary: secondary ?? this.secondary,
      secondaryVariant: secondaryVariant ?? this.secondaryVariant,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      error: error ?? this.error,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      onBackground: onBackground ?? this.onBackground,
      onSurface: onSurface ?? this.onSurface,
      onError: onError ?? this.onError,
      bottomNavigationBarColor:
          bottomNavigationBarColor ?? this.bottomNavigationBarColor,      
      homeHeaderColor: homeHeaderColor ?? this.homeHeaderColor,
      homeBackgroundColor: homeBackgroundColor ?? this.homeBackgroundColor,
      ffC5CBC6: ffC5CBC6 ?? this.ffC5CBC6, // New color property
      ffDDA815: ffDDA815 ?? this.ffDDA815, // New color property
      ff8D8B8B: ff8D8B8B ?? this.ff8D8B8B, // New color property
      ffBDA386: ffBDA386 ?? this.ffBDA386, // New color property
      ffF5F5F5: ffF5F5F5 ?? this.ffF5F5F5, // New color property
      ffbfa56d: ffbfa56d ?? this.ffbfa56d, // New color property
      ff5C5869: ff5C5869 ?? this.ff5C5869, // New color property
      ff535B70: ff535B70 ?? this.ff535B70, // New color property
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) {
      return this;
    }
    return AppThemeColors(
      primary: Color.lerp(primary, other.primary, t),
      primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      secondaryVariant: Color.lerp(secondaryVariant, other.secondaryVariant, t),
      background: Color.lerp(background, other.background, t),
      surface: Color.lerp(surface, other.surface, t),
      error: Color.lerp(error, other.error, t),
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t),
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t),
      onBackground: Color.lerp(onBackground, other.onBackground, t),
      onSurface: Color.lerp(onSurface, other.onSurface, t),
      onError: Color.lerp(onError, other.onError, t),
      bottomNavigationBarColor: Color.lerp(
          bottomNavigationBarColor, other.bottomNavigationBarColor, t),
      homeHeaderColor: Color.lerp(
          homeHeaderColor, other.homeHeaderColor, t),
      homeBackgroundColor: Color.lerp(
          homeBackgroundColor, other.homeBackgroundColor, t),
      
      ffC5CBC6: Color.lerp(ffC5CBC6, other.ffC5CBC6, t), // New color property
      ffDDA815: Color.lerp(ffDDA815, other.ffDDA815, t), // New color property
      ff8D8B8B: Color.lerp(ff8D8B8B, other.ff8D8B8B, t), // New color property
      ff252525: Color.lerp(ff252525, other.ff252525, t), // New color property
      ffBDA386: Color.lerp(ffBDA386, other.ffBDA386, t), // New color property
      ffF5F5F5: Color.lerp(ffF5F5F5, other.ffF5F5F5, t), // New color property
      ffbfa56d: Color.lerp(ffbfa56d, other.ffbfa56d, t), // New color property
      ff5C5869: Color.lerp(ff5C5869, other.ff5C5869, t), // New color property
      ff535B70: Color.lerp(ff535B70, other.ff535B70, t), // New color property
    );
  }

  factory AppThemeColors.light() {
    return AppThemeColors(
      primary: const Color(0xffbfa46d),
      primaryVariant: const Color(0xFF3700B3),
      secondary: const Color(0xFF03DAC6),
      secondaryVariant: const Color(0xFF018786),
      background: const Color(0xFFFFFFFF),
      surface: const Color(0xFFFFFFFF),
      error: const Color(0xFFB00020),
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFF000000),
      onBackground: const Color(0xFF000000),
      onSurface: const Color(0xFF000000),
      onError: const Color(0xFFFFFFFF),
      bottomNavigationBarColor: const Color(0xFFC5CBC6),
      homeHeaderColor: const Color(0xFFC5CBC6),
      homeBackgroundColor: const Color(0xFFFFFFFF),
      ffC5CBC6: const Color(0xffC5CBC6), // New color value for light theme
      ffDDA815: const Color(0xffDDA815), // New color value for light theme
      ff8D8B8B: const Color(0xff8D8B8B), // New color value for light theme
      ff252525: const Color(0xff252525), // New color value for light theme
      ffBDA386: const Color(0xffBDA386),
      ffF5F5F5: const Color(0xffF5F5F5),
      ffbfa56d: const Color(0xffbfa56d), 
      ff5C5869: const Color(0xff5C5869), 
      ff535B70: const Color(0xff535B70), 
    );
  }

  factory AppThemeColors.dark() {
    return AppThemeColors(
      primary: const Color(0xFFBB86FC),
      primaryVariant: const Color(0xFF3700B3),
      secondary: const Color(0xFF03DAC6),
      secondaryVariant: const Color(0xFF03DAC6),
      background: const Color(0xFF121212),
      surface: const Color(0xFF121212),
      error: const Color(0xFFCF6679),
      onPrimary: const Color(0xFF000000),
      onSecondary: const Color(0xFF000000),
      onBackground: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFFFFFFFF),
      onError: const Color(0xFF000000),
      bottomNavigationBarColor: const Color(0xFF121212),
      ffC5CBC6: const Color(0xffC5CBC6), // New color value for dark theme
      ffDDA815: const Color(0xffDDA815),
      ff8D8B8B: const Color(0xff8D8B8B),
      ff252525: const Color(0xff252525),
      ffBDA386: const Color(0xffBDA386),
      ffF5F5F5: const Color(0xffF5F5F5),
      ffbfa56d: const Color(0xffbfa56d),
      ff5C5869: const Color(0xff5C5869),
      ff535B70: const Color(0xff535B70),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppThemeColors &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          primaryVariant == other.primaryVariant &&
          secondary == other.secondary &&
          secondaryVariant == other.secondaryVariant &&
          background == other.background &&
          surface == other.surface &&
          error == other.error &&
          onPrimary == other.onPrimary &&
          onSecondary == other.onSecondary &&
          onBackground == other.onBackground &&
          onSurface == other.onSurface &&
          onError == other.onError &&
          bottomNavigationBarColor == other.bottomNavigationBarColor &&
          homeBackgroundColor == other.homeBackgroundColor &&
          homeHeaderColor == other.homeHeaderColor &&
          ffC5CBC6 == other.ffC5CBC6 && // New color property
          ffDDA815 == other.ffDDA815 && // New color property
          ff8D8B8B == other.ff8D8B8B && // New color property
          ff252525 == other.ff252525 && // New color property
          ffF5F5F5 == other.ffF5F5F5 && // New color property
          ffBDA386 == other.ffBDA386 && // New color property
          ffbfa56d == other.ffbfa56d &&
          ff5C5869 == other.ff5C5869 &&
          ff535B70 == other.ff535B70;
  @override
  int get hashCode =>
      primary.hashCode ^
      primaryVariant.hashCode ^
      primaryVariant.hashCode ^
      secondary.hashCode ^
      secondaryVariant.hashCode ^
      background.hashCode ^
      surface.hashCode ^
      error.hashCode ^
      onPrimary.hashCode ^
      onSecondary.hashCode ^
      onBackground.hashCode ^
      onSurface.hashCode ^
      onError.hashCode ^
      bottomNavigationBarColor.hashCode ^
      homeHeaderColor.hashCode ^
      homeBackgroundColor.hashCode ^      
      ffC5CBC6.hashCode ^ // New color property
      ffDDA815.hashCode ^ // New color property
      ff8D8B8B.hashCode ^ // New color property
      ff252525.hashCode ^ // New color property
      ffBDA386.hashCode ^
      ffF5F5F5.hashCode ^ // New color property
      ffbfa56d.hashCode ^
      ff5C5869.hashCode ^
      ff535B70.hashCode;
}