import 'package:flutter/material.dart';

import 'misc.dart';

enum GiphyThemePreset { automatic, dark, light }

class GiphyTheme {
  final GiphyThemePreset? preset;

  // Dialog's handle
  final Color? handleBarColor;

  // Emoji drawer
  final Color? emojiDrawerGradientBottomColor;
  final Color? emojiDrawerGradientTopColor;
  final IndicatorStyle? emojiDrawerScrollIndicatorStyle;
  final Color? emojiDrawerSeparatorColor;

  // Search bar
  final Color? searchBackButtonColor;
  final Color? searchBarBackgroundColor;
  final double? searchBarCornerRadius;
  final double? searchBarPadding;
  final Color? searchPlaceholderTextColor;
  final Color? searchTextColor;

  // Suggestions
  final Color? suggestionCellBackgroundColor;
  final Color? suggestionCellTextColor;

  // Tab bar
  final double? tabBarBackgroundAlpha;
  final Color? tabBarSwitchDefaultColor;
  final Color? tabBarSwitchSelectedColor;

  // Confirmation
  final Color? avatarPlaceholderColor;
  final Color? confirmationBackButtonColor;
  final Color? confirmationSelectButtonColor;
  final Color? confirmationSelectButtonTextColor;
  final Color? confirmationViewOnGiphyColor;
  final Color? usernameColor;

  // Grid content
  final Color? backgroundColorForLoadingCells;
  final double? cellCornerRadius;
  final bool? fixedSizeCells;
  final Color? stickerBackgroundColor;

  // Keyboard
  final KeyboardAppearance? keyboardAppearance;

  // Other
  final Color? backgroundColor;
  final Color? defaultTextColor;
  final Color? dialogOverlayBackgroundColor;
  final Color? retryButtonBackgroundColor;
  final Color? retryButtonTextColor;

  GiphyTheme._private({
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

  factory GiphyTheme.fromPreset({
    required GiphyThemePreset preset,
    Color? handleBarColor,
    Color? emojiDrawerGradientBottomColor,
    Color? emojiDrawerGradientTopColor,
    IndicatorStyle? emojiDrawerScrollIndicatorStyle,
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
    KeyboardAppearance? keyboardAppearance,
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

  Map<String, dynamic> toJson() {
    return {
      'preset': preset?.toString().split('.').last,
      'handleBarColor': handleBarColor?.value,
      'emojiDrawerGradientBottomColor': emojiDrawerGradientBottomColor?.value,
      'emojiDrawerGradientTopColor': emojiDrawerGradientTopColor?.value,
      'emojiDrawerScrollIndicatorStyle': emojiDrawerScrollIndicatorStyle != null
          ? IndicatorStyleExtension.toStringValue(
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
          ? KeyboardAppearanceExtension.toStringValue(keyboardAppearance!)
          : null,
      'backgroundColor': backgroundColor?.value,
      'defaultTextColor': defaultTextColor?.value,
      'dialogOverlayBackgroundColor': dialogOverlayBackgroundColor?.value,
      'retryButtonBackgroundColor': retryButtonBackgroundColor?.value,
      'retryButtonTextColor': retryButtonTextColor?.value,
    };
  }
}
