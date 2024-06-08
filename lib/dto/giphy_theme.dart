import 'package:flutter/material.dart';

import 'misc.dart';

/// An enumeration representing different presets for the Giphy theme.
enum GiphyThemePreset {
  /// Automatically switch theme based on system settings.
  automatic,

  /// Dark theme.
  dark,

  /// Light theme.
  light
}

/// This class defines the theme settings for the Giphy dialog.
///
/// It includes settings such as colors, text styles, and other UI parameters
/// to customize the look and feel of the Giphy dialog.
class GiphyTheme {
  /// The preset theme for this configuration.
  final GiphyThemePreset? preset;

  /// The color of the dialog's handlebar.
  final Color? handleBarColor;

  /// The bottom gradient color for the emoji drawer.
  final Color? emojiDrawerGradientBottomColor;

  /// The top gradient color for the emoji drawer.
  final Color? emojiDrawerGradientTopColor;

  /// The style of the scroll indicator in the emoji drawer.
  final GiphyIndicatorStyle? emojiDrawerScrollIndicatorStyle;

  /// The color of the emoji drawer separator.
  final Color? emojiDrawerSeparatorColor;

  /// The color of the back button in the search bar.
  final Color? searchBackButtonColor;

  /// The background color of the search bar.
  final Color? searchBarBackgroundColor;

  /// The corner radius of the search bar.
  final double? searchBarCornerRadius;

  /// The padding of the search bar.
  final double? searchBarPadding;

  /// The placeholder text color in the search bar.
  final Color? searchPlaceholderTextColor;

  /// The text color in the search bar.
  final Color? searchTextColor;

  /// The background color of suggestion cells.
  final Color? suggestionCellBackgroundColor;

  /// The text color of suggestion cells.
  final Color? suggestionCellTextColor;

  /// The background alpha of the tab bar.
  final double? tabBarBackgroundAlpha;

  /// The default color of the tab bar switch.
  final Color? tabBarSwitchDefaultColor;

  /// The selected color of the tab bar switch.
  final Color? tabBarSwitchSelectedColor;

  /// The placeholder color for avatars.
  final Color? avatarPlaceholderColor;

  /// The color of the back button in the confirmation view.
  final Color? confirmationBackButtonColor;

  /// The color of the select button in the confirmation view.
  final Color? confirmationSelectButtonColor;

  /// The text color of the select button in the confirmation view.
  final Color? confirmationSelectButtonTextColor;

  /// The color of the 'View on Giphy' button in the confirmation view.
  final Color? confirmationViewOnGiphyColor;

  /// The color of usernames in the confirmation view.
  final Color? usernameColor;

  /// The background color for loading cells in the grid.
  final Color? backgroundColorForLoadingCells;

  /// The corner radius of grid cells.
  final double? cellCornerRadius;

  /// Whether the cells have a fixed size.
  final bool? fixedSizeCells;

  /// The background color for stickers.
  final Color? stickerBackgroundColor;

  /// The appearance of the Giphy keyboard.
  final GiphyKeyboardAppearance? keyboardAppearance;

  /// The background color of the dialog.
  final Color? backgroundColor;

  /// The default text color in the dialog.
  final Color? defaultTextColor;

  /// The background color of the dialog overlay.
  final Color? dialogOverlayBackgroundColor;

  /// The background color of the retry button.
  final Color? retryButtonBackgroundColor;

  /// The text color of the retry button.
  final Color? retryButtonTextColor;

  /// Predefined automatic Giphy theme.
  static const GiphyTheme automaticTheme = GiphyTheme._private(preset: GiphyThemePreset.automatic);

  // Private constructor with optional parameters.
  const GiphyTheme._private({
    this.preset,
    this.handleBarColor,
    this.emojiDrawerGradientBottomColor,
    this.emojiDrawerGradientTopColor,
    this.emojiDrawerScrollIndicatorStyle,
    this.emojiDrawerSeparatorColor,
    this.searchBackButtonColor,
    this.searchBarBackgroundColor,
    this.searchBarCornerRadius,
    this.searchBarPadding,
    this.searchPlaceholderTextColor,
    this.searchTextColor,
    this.suggestionCellBackgroundColor,
    this.suggestionCellTextColor,
    this.tabBarBackgroundAlpha,
    this.tabBarSwitchDefaultColor,
    this.tabBarSwitchSelectedColor,
    this.avatarPlaceholderColor,
    this.confirmationBackButtonColor,
    this.confirmationSelectButtonColor,
    this.confirmationSelectButtonTextColor,
    this.confirmationViewOnGiphyColor,
    this.usernameColor,
    this.backgroundColorForLoadingCells,
    this.cellCornerRadius,
    this.fixedSizeCells,
    this.stickerBackgroundColor,
    this.keyboardAppearance,
    this.backgroundColor,
    this.defaultTextColor,
    this.dialogOverlayBackgroundColor,
    this.retryButtonBackgroundColor,
    this.retryButtonTextColor,
  });

  /// Factory constructor to create an automatic Giphy theme.
  factory GiphyTheme.automatic() {
    return const GiphyTheme._private(preset: GiphyThemePreset.automatic);
  }

  /// Factory constructor to create a light Giphy theme.
  factory GiphyTheme.light() {
    return const GiphyTheme._private(preset: GiphyThemePreset.light);
  }

  /// Factory constructor to create a dark Giphy theme.
  factory GiphyTheme.dark() {
    return const GiphyTheme._private(preset: GiphyThemePreset.dark);
  }

  /// Factory constructor to create a Giphy theme from a given preset.
  factory GiphyTheme.fromPreset({
    required GiphyThemePreset preset,
    Color? handleBarColor,
    Color? emojiDrawerGradientBottomColor,
    Color? emojiDrawerGradientTopColor,
    GiphyIndicatorStyle? emojiDrawerScrollIndicatorStyle,
    Color? emojiDrawerSeparatorColor,
    Color? searchBackButtonColor,
    Color? searchBarBackgroundColor,
    double? searchBarCornerRadius,
    double? searchBarPadding,
    Color? searchPlaceholderTextColor,
    Color? searchTextColor,
    Color? suggestionCellBackgroundColor,
    Color? suggestionCellTextColor,
    double? tabBarBackgroundAlpha,
    Color? tabBarSwitchDefaultColor,
    Color? tabBarSwitchSelectedColor,
    Color? avatarPlaceholderColor,
    Color? confirmationBackButtonColor,
    Color? confirmationSelectButtonColor,
    Color? confirmationSelectButtonTextColor,
    Color? confirmationViewOnGiphyColor,
    Color? usernameColor,
    Color? backgroundColorForLoadingCells,
    double? cellCornerRadius,
    bool? fixedSizeCells,
    Color? stickerBackgroundColor,
    GiphyKeyboardAppearance? keyboardAppearance,
    Color? backgroundColor,
    Color? defaultTextColor,
    Color? dialogOverlayBackgroundColor,
    Color? retryButtonBackgroundColor,
    Color? retryButtonTextColor,
  }) {
    return GiphyTheme._private(
      preset: preset,
      handleBarColor: handleBarColor,
      emojiDrawerGradientBottomColor: emojiDrawerGradientBottomColor,
      emojiDrawerGradientTopColor: emojiDrawerGradientTopColor,
      emojiDrawerScrollIndicatorStyle: emojiDrawerScrollIndicatorStyle,
      emojiDrawerSeparatorColor: emojiDrawerSeparatorColor,
      searchBackButtonColor: searchBackButtonColor,
      searchBarBackgroundColor: searchBarBackgroundColor,
      searchBarCornerRadius: searchBarCornerRadius,
      searchBarPadding: searchBarPadding,
      searchPlaceholderTextColor: searchPlaceholderTextColor,
      searchTextColor: searchTextColor,
      suggestionCellBackgroundColor: suggestionCellBackgroundColor,
      suggestionCellTextColor: suggestionCellTextColor,
      tabBarBackgroundAlpha: tabBarBackgroundAlpha,
      tabBarSwitchDefaultColor: tabBarSwitchDefaultColor,
      tabBarSwitchSelectedColor: tabBarSwitchSelectedColor,
      avatarPlaceholderColor: avatarPlaceholderColor,
      confirmationBackButtonColor: confirmationBackButtonColor,
      confirmationSelectButtonColor: confirmationSelectButtonColor,
      confirmationSelectButtonTextColor: confirmationSelectButtonTextColor,
      confirmationViewOnGiphyColor: confirmationViewOnGiphyColor,
      usernameColor: usernameColor,
      backgroundColorForLoadingCells: backgroundColorForLoadingCells,
      cellCornerRadius: cellCornerRadius,
      fixedSizeCells: fixedSizeCells,
      stickerBackgroundColor: stickerBackgroundColor,
      keyboardAppearance: keyboardAppearance,
      backgroundColor: backgroundColor,
      defaultTextColor: defaultTextColor,
      dialogOverlayBackgroundColor: dialogOverlayBackgroundColor,
      retryButtonBackgroundColor: retryButtonBackgroundColor,
      retryButtonTextColor: retryButtonTextColor,
    );
  }

  /// Converts the GiphyTheme instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'preset': preset?.toString().split('.').last,
      'handleBarColor': handleBarColor?.value,
      'emojiDrawerGradientBottomColor': emojiDrawerGradientBottomColor?.value,
      'emojiDrawerGradientTopColor': emojiDrawerGradientTopColor?.value,
      'emojiDrawerScrollIndicatorStyle': emojiDrawerScrollIndicatorStyle != null
          ? GiphyIndicatorStyleExtension.toStringValue(
              emojiDrawerScrollIndicatorStyle!)
          : null,
      'emojiDrawerSeparatorColor': emojiDrawerSeparatorColor?.value,
      'searchBackButtonColor': searchBackButtonColor?.value,
      'searchBarBackgroundColor': searchBarBackgroundColor?.value,
      'searchBarCornerRadius': searchBarCornerRadius,
      'searchBarPadding': searchBarPadding,
      'searchPlaceholderTextColor': searchPlaceholderTextColor?.value,
      'searchTextColor': searchTextColor?.value,
      'suggestionCellBackgroundColor': suggestionCellBackgroundColor?.value,
      'suggestionCellTextColor': suggestionCellTextColor?.value,
      'tabBarBackgroundAlpha': tabBarBackgroundAlpha,
      'tabBarSwitchDefaultColor': tabBarSwitchDefaultColor?.value,
      'tabBarSwitchSelectedColor': tabBarSwitchSelectedColor?.value,
      'avatarPlaceholderColor': avatarPlaceholderColor?.value,
      'confirmationBackButtonColor': confirmationBackButtonColor?.value,
      'confirmationSelectButtonColor': confirmationSelectButtonColor?.value,
      'confirmationSelectButtonTextColor':
          confirmationSelectButtonTextColor?.value,
      'confirmationViewOnGiphyColor': confirmationViewOnGiphyColor?.value,
      'usernameColor': usernameColor?.value,
      'backgroundColorForLoadingCells': backgroundColorForLoadingCells?.value,
      'cellCornerRadius': cellCornerRadius,
      'fixedSizeCells': fixedSizeCells,
      'stickerBackgroundColor': stickerBackgroundColor?.value,
      'keyboardAppearance': keyboardAppearance != null
          ? GiphyKeyboardAppearanceExtension.toStringValue(keyboardAppearance!)
          : null,
      'backgroundColor': backgroundColor?.value,
      'defaultTextColor': defaultTextColor?.value,
      'dialogOverlayBackgroundColor': dialogOverlayBackgroundColor?.value,
      'retryButtonBackgroundColor': retryButtonBackgroundColor?.value,
      'retryButtonTextColor': retryButtonTextColor?.value,
    };
  }
}
