import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_request.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';
import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/giphy_dialog.dart';
import 'package:giphy_flutter_sdk/giphy_grid_view.dart';
import 'package:giphy_flutter_sdk/giphy_media_view.dart';
import 'package:giphy_flutter_sdk/giphy_video_manager.dart';
import 'package:giphy_flutter_sdk/giphy_video_view.dart';
import 'package:giphy_flutter_sdk_example/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    implements GiphyMediaSelectionListener {
  GiphySettings _settings = const GiphySettings();
  final List<GiphyMedia> _mediaList = [];

  final FocusNode _focusNode = FocusNode();
  bool _isSearchFocused = false;

  GiphyContentRequest _gridContentRequest = GiphyContentRequest.trendingGifs();

  @override
  void initState() {
    super.initState();
    GiphyDialog.instance.addListener(this);
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isSearchFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    GiphyDialog.instance.removeListener(this);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (!_isSearchFocused) const Divider(),
        if (!_isSearchFocused)
          ListTile(
            title: const Text('Dialog Settings'),
            onTap: () {
              _showSettingsModal(context);
            },
          ),
        if (!_isSearchFocused) const Divider(),
        if (!_isSearchFocused)
          ListTile(
            title: const Text('Show Dialog'),
            onTap: () {
              _showGiphyDialog();
            },
          ),
        if (!_isSearchFocused) const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _focusNode,
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            onChanged: (text) {
              setState(() {
                if (text.isNotEmpty) {
                  _gridContentRequest = GiphyContentRequest.search(
                      mediaType: GiphyMediaType.gif, searchQuery: text);
                } else {
                  _gridContentRequest = GiphyContentRequest.trendingGifs();
                }
              });
            },
          ),
        ),
        if (!_isSearchFocused) const Divider(),
        if (!_isSearchFocused)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Preview',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
        Expanded(
          child: _isSearchFocused
              ? _buildSearchResults()
              : _buildGiphyMediaViews(),
        ),
      ],
    );
  }

  void _showSettingsModal(BuildContext context) async {
    GiphyVideoManager.instance.muteAll();
    final resultSettings = await showModalBottomSheet<GiphySettings>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: SettingsScreen(settings: _settings),
        );
      },
    );

    if (resultSettings != null) {
      setState(() {
        _settings = resultSettings;
      });
    }
  }

  void _showGiphyDialog() {
    GiphyVideoManager.instance.muteAll();
    GiphyDialog.instance.configure(settings: _settings);
    GiphyDialog.instance.show();
  }

  Widget _buildSearchResults() {
    return Column(
      children: <Widget>[
        Expanded(
          child: GiphyGridView(
            content: _gridContentRequest,
            renditionType: _settings.renditionType ?? GiphyRendition.fixedWidth,
            theme: _settings.theme,
            onMediaSelect: (GiphyMedia media) {
              onMediaSelect(media);
              _focusNode.unfocus();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              _focusNode.unfocus();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Close'),
          ),
        ),
      ],
    );
  }

  Widget _buildGiphyMediaViews() {
    return ListView.builder(
      itemCount: _mediaList.length,
      itemBuilder: (context, index) {
        Widget mediaItem = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: AspectRatio(
            aspectRatio: _mediaList[index].aspectRatio,
            child: _mediaList[index].isVideo
                ? GiphyVideoView(
              media: _mediaList[index],
              autoPlay: true,
              muted: true,
            )
                : _mediaList[index].isDynamic
                ? Image(
              image: NetworkImage(_mediaList[index].images.original!.gifUrl!),
            )
                : GiphyMediaView(
              media: _mediaList[index],
              autoPlay: true,
              renditionType: GiphyRendition.fixedWidth,
            ),
          ),
        );
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: mediaItem,
        );
      },
    );
  }

  @override
  void onMediaSelect(GiphyMedia media) {
    setState(() {
      _mediaList.add(media);
    });
  }

  @override
  void onDismiss() {
    print("Giphy dialog dismissed");
  }
}
