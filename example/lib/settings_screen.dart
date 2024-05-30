import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_file_format.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rating.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';
import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/dto/giphy_theme.dart';

class SettingsScreen extends StatefulWidget {
  final GiphySettings settings;

  const SettingsScreen({super.key, required this.settings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late GiphySettings _temporarySettings;

  @override
  void initState() {
    super.initState();
    _temporarySettings = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.of(context).pop(_temporarySettings);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(children: [
          Expanded(
              child: ListView(
            children: [
              ListTile(
                title: const Text('Theme'),
                trailing: DropdownButton<String>(
                  value: getThemeString(),
                  onChanged: (String? newValue) {
                    _updateTheme(newValue ?? "Automatic");
                  },
                  items: <String>['Dark', 'Light', 'Automatic']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              const ListTile(
                title: Text('Media Type Config'),
              ),
              SwitchListTile(
                title: const Text('Recents'),
                value: _temporarySettings
                    .isContentTypeEnabled(GiphyContentType.recents),
                onChanged: (bool value) {
                  _toggleContentType(GiphyContentType.recents, value);
                },
              ),
              SwitchListTile(
                title: const Text('Gif'),
                value: _temporarySettings
                    .isContentTypeEnabled(GiphyContentType.gif),
                onChanged: (bool value) {
                  _toggleContentType(GiphyContentType.gif, value);
                },
              ),
              SwitchListTile(
                title: const Text('Sticker'),
                value: _temporarySettings
                    .isContentTypeEnabled(GiphyContentType.sticker),
                onChanged: (bool value) {
                  _toggleContentType(GiphyContentType.sticker, value);
                },
              ),
              SwitchListTile(
                title: const Text('Emoji'),
                value: _temporarySettings
                    .isContentTypeEnabled(GiphyContentType.emoji),
                onChanged: (bool value) {
                  _toggleContentType(GiphyContentType.emoji, value);
                },
              ),
              SwitchListTile(
                title: const Text('Text'),
                value: _temporarySettings
                    .isContentTypeEnabled(GiphyContentType.text),
                onChanged: (bool value) {
                  _toggleContentType(GiphyContentType.text, value);
                },
              ),
              SwitchListTile(
                title: const Text('Clips'),
                value: _temporarySettings
                    .isContentTypeEnabled(GiphyContentType.clips),
                onChanged: (bool value) {
                  _toggleContentType(GiphyContentType.clips, value);
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Enable Dynamic Text'),
                value: _temporarySettings.enableDynamicText,
                onChanged: (bool value) {
                  _toggleDynamicTexts();
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Rating'),
                trailing: DropdownButton<GiphyRating>(
                  value: _temporarySettings.rating,
                  onChanged: (GiphyRating? newValue) {
                    setState(() {
                      _temporarySettings = _temporarySettings.copyWith(
                          rating: newValue ?? GiphyRating.pg13);
                    });
                  },
                  items: GiphyRating.values
                      .map<DropdownMenuItem<GiphyRating>>((GiphyRating value) {
                    return DropdownMenuItem<GiphyRating>(
                      value: value,
                      child: Text(GiphyRatingExtension.toStringValue(value)),
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Rendition Type'),
                trailing: DropdownButton<GiphyRendition>(
                  value: _temporarySettings.renditionType,
                  onChanged: (GiphyRendition? newValue) {
                    setState(() {
                      _temporarySettings = _temporarySettings.copyWith(
                          renditionType: newValue ?? GiphyRendition.fixedWidth);
                    });
                  },
                  items: GiphyRendition.values
                      .map<DropdownMenuItem<GiphyRendition>>(
                          (GiphyRendition value) {
                    return DropdownMenuItem<GiphyRendition>(
                      value: value,
                      child: Text(GiphyRenditionUtil.toStringValue(value)),
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('File Type'),
                trailing: DropdownButton<GiphyFileFormat>(
                  value: _temporarySettings.fileFormat,
                  onChanged: (GiphyFileFormat? newValue) {
                    setState(() {
                      _temporarySettings = _temporarySettings.copyWith(
                          fileFormat: newValue ?? GiphyFileFormat.webp);
                    });
                  },
                  items: GiphyFileFormat.values
                      .map<DropdownMenuItem<GiphyFileFormat>>(
                          (GiphyFileFormat value) {
                    return DropdownMenuItem<GiphyFileFormat>(
                      value: value,
                      child:
                          Text(GiphyFileFormatExtension.toStringValue(value)),
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Show Confirmation Screen'),
                value: _temporarySettings.showConfirmationScreen,
                onChanged: (bool value) {
                  setState(() {
                    _temporarySettings = _temporarySettings.copyWith(
                        showConfirmationScreen:
                            !_temporarySettings.showConfirmationScreen);
                  });
                },
              ),
              ListTile(
                title: const Text('Sticker Column Count'),
                trailing: DropdownButton<int>(
                  value: _temporarySettings.stickerColumnCount,
                  onChanged: (int? newValue) {
                    setState(() {
                      _temporarySettings = _temporarySettings.copyWith(
                          stickerColumnCount: newValue ?? 2);
                    });
                  },
                  items: <int>[2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Selected Content Type'),
                trailing: DropdownButton<GiphyContentType>(
                  value: _temporarySettings.selectedContentType,
                  onChanged: (GiphyContentType? newValue) {
                    setState(() {
                      _temporarySettings = _temporarySettings.copyWith(
                          selectedContentType:
                              newValue ?? GiphyContentType.gif);
                    });
                  },
                  items: GiphyContentType.values
                      .map<DropdownMenuItem<GiphyContentType>>(
                          (GiphyContentType value) {
                    return DropdownMenuItem<GiphyContentType>(
                      value: value,
                      child:
                          Text(GiphyContentTypeExtension.toStringValue(value)),
                    );
                  }).toList(),
                ),
              ),
            ],
          )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_temporarySettings);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _updateTheme(String themeString) {
    setState(() {
      GiphyTheme theme;
      if (themeString == "Dark") {
        theme = GiphyTheme.fromPreset(preset: GiphyThemePreset.dark);
      } else if (themeString == "Light") {
        theme = GiphyTheme.fromPreset(preset: GiphyThemePreset.light);
      } else {
        theme = GiphyTheme.fromPreset(preset: GiphyThemePreset.automatic);
      }
      _temporarySettings = _temporarySettings.copyWith(theme: theme);
    });
  }

  String getThemeString() {
    if (_temporarySettings.theme.preset == GiphyThemePreset.light) {
      return "Light";
    }
    if (_temporarySettings.theme.preset == GiphyThemePreset.dark) {
      return "Dark";
    }
    return "Automatic";
  }

  void _toggleContentType(GiphyContentType contentType, bool isEnabled) {
    setState(() {
      final preferredOrder = [
        GiphyContentType.recents,
        GiphyContentType.gif,
        GiphyContentType.sticker,
        GiphyContentType.emoji,
        GiphyContentType.text,
        GiphyContentType.clips,
      ];

      final newConfig = <GiphyContentType>[];

      final currentConfig = _temporarySettings.mediaTypeConfig;
      List<GiphyContentType> modifiedConfig;
      if (isEnabled) {
        modifiedConfig = currentConfig.contains(contentType)
            ? currentConfig
            : [...currentConfig, contentType];
      } else {
        modifiedConfig =
            currentConfig.where((type) => type != contentType).toList();
      }

      for (var type in preferredOrder) {
        if (modifiedConfig.contains(type)) {
          newConfig.add(type);
        }
      }
      _temporarySettings =
          _temporarySettings.copyWith(mediaTypeConfig: newConfig);
    });
  }

  void _toggleDynamicTexts() {
    setState(() {
      _temporarySettings = _temporarySettings.copyWith(
          enableDynamicText: !_temporarySettings.enableDynamicText);
    });
  }
}
