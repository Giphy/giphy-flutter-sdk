// Checks how settings, content requests, themes and media convert to and from the JSON
// that crosses to the native side. The keys and string values here are the ones the
// native code reads (see GiphyFlutterTypeExtensions.swift on iOS), so a failing test
// means the native side would no longer understand Dart, or the other way round.
//   flutter test

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_request.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_file_format.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rating.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';
import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/dto/giphy_theme.dart';

import 'fixtures.dart';

void main() {
  group('GiphySettings', () {
    test('defaults', () {
      final json = const GiphySettings().toJson();

      expect(Map.of(json)..remove('theme'), {
        'mediaTypeConfig': [
          'recents',
          'gif',
          'sticker',
          'text',
          'emoji',
          'clips'
        ],
        'showConfirmationScreen': false,
        'rating': 'pg13',
        'renditionType': null,
        'clipsPreviewRenditionType': null,
        'confirmationRenditionType': null,
        'showCheckeredBackground': false,
        'stickerColumnCount': 3,
        'selectedContentType': 'gif',
        'showSuggestionsBar': true,
        'enableDynamicText': false,
        'fileFormat': 'webp',
        'disableEmojiVariations': false,
        'enableEdgeToEdge': false,
      });
      expect(json['theme'], containsPair('preset', 'automatic'));
    });

    test('every field set', () {
      final json = GiphySettings(
        theme: GiphyTheme.dark(),
        mediaTypeConfig: [GiphyContentType.gif, GiphyContentType.clips],
        showConfirmationScreen: true,
        rating: GiphyRating.r,
        renditionType: GiphyRendition.original,
        clipsPreviewRenditionType: GiphyClipsRendition.fixedHeight,
        confirmationRenditionType: GiphyRendition.downsized,
        showCheckeredBackground: true,
        stickerColumnCount: 4,
        selectedContentType: GiphyContentType.clips,
        showSuggestionsBar: false,
        enableDynamicText: true,
        fileFormat: GiphyFileFormat.mp4,
        disableEmojiVariations: true,
        enableEdgeToEdge: true,
      ).toJson();

      expect(Map.of(json)..remove('theme'), {
        'mediaTypeConfig': ['gif', 'clips'],
        'showConfirmationScreen': true,
        'rating': 'r',
        'renditionType': 'original',
        'clipsPreviewRenditionType': 'fixedHeight',
        'confirmationRenditionType': 'downsized',
        'showCheckeredBackground': true,
        'stickerColumnCount': 4,
        'selectedContentType': 'clips',
        'showSuggestionsBar': false,
        'enableDynamicText': true,
        'fileFormat': 'mp4',
        'disableEmojiVariations': true,
        'enableEdgeToEdge': true,
      });
      expect(json['theme'], containsPair('preset', 'dark'));
    });
  });

  group('GiphyTheme', () {
    test('sends the preset and colors as ARGB integers', () {
      final json = GiphyTheme.fromPreset(
        preset: GiphyThemePreset.light,
        handleBarColor: const Color(0xFF112233),
        searchBarBackgroundColor: const Color(0x80FFFFFF),
      ).toJson();

      expect(json['preset'], 'light');
      expect(json['handleBarColor'], 0xFF112233);
      expect(json['searchBarBackgroundColor'], 0x80FFFFFF);
    });

    test('sends nothing but the preset for the built-in themes', () {
      for (final (theme, preset) in [
        (GiphyTheme.automatic(), 'automatic'),
        (GiphyTheme.light(), 'light'),
        (GiphyTheme.dark(), 'dark'),
      ]) {
        final values = theme.toJson().values.where((value) => value != null);
        expect(values, [preset]);
      }
    });
  });

  group('GiphyContentRequest', () {
    final cases = <String, (GiphyContentRequest, Map<String, Object?>)>{
      'search': (
        GiphyContentRequest.search(
            mediaType: GiphyMediaType.sticker, searchQuery: 'cat'),
        {
          'mediaType': 'sticker',
          'rating': 'pg13',
          'requestType': 'search',
          'searchQuery': 'cat'
        },
      ),
      'trending GIFs': (
        GiphyContentRequest.trendingGifs(rating: GiphyRating.g),
        {
          'mediaType': 'gif',
          'rating': 'g',
          'requestType': 'trending',
          'searchQuery': null
        },
      ),
      'trending stickers': (
        GiphyContentRequest.trendingStickers(),
        {
          'mediaType': 'sticker',
          'rating': 'pg13',
          'requestType': 'trending',
          'searchQuery': null
        },
      ),
      'trending text': (
        GiphyContentRequest.trendingText(),
        {
          'mediaType': 'text',
          'rating': 'pg13',
          'requestType': 'trending',
          'searchQuery': null
        },
      ),
      'trending clips': (
        GiphyContentRequest.trending(mediaType: GiphyMediaType.video),
        {
          'mediaType': 'video',
          'rating': 'pg13',
          'requestType': 'trending',
          'searchQuery': null
        },
      ),
      'recents': (
        GiphyContentRequest.recents(),
        {
          'mediaType': 'gif',
          'rating': null,
          'requestType': 'recents',
          'searchQuery': null
        },
      ),
      'emoji': (
        GiphyContentRequest.emoji(),
        {
          'mediaType': 'emoji',
          'rating': null,
          'requestType': 'emoji',
          'searchQuery': null
        },
      ),
      'animate': (
        GiphyContentRequest.animate('hello'),
        {
          'mediaType': 'text',
          'rating': null,
          'requestType': 'animate',
          'searchQuery': 'hello'
        },
      ),
    };

    cases.forEach((name, testCase) {
      final (request, expected) = testCase;

      test('$name converts to JSON', () {
        expect(request.toJson(), expected);
      });

      test('$name converts back from JSON', () {
        final parsed = GiphyContentRequest.fromJson(request.toJson());
        expect(parsed.requestType, request.requestType);
        expect(parsed.mediaType, request.mediaType);
        expect(parsed.rating, request.rating);
        // fromJson turns a missing query into ''.
        expect(parsed.searchQuery, request.searchQuery ?? '');
      });
    });
  });

  group('GiphyMedia', () {
    test('parses a GIF sent by the native side', () {
      final media = GiphyMedia.fromJson(gifFromNative);

      expect(media.id, 'LRs6P30O9lWaRjzdN0');
      expect(media.type, GiphyMediaType.gif);
      expect(media.rating, GiphyRating.g);
      expect(media.title, 'Test GIF');
      expect(media.tags, ['test', 'gif']);
      expect(media.aspectRatio, 1.5);
      expect(media.isVideo, isFalse);
      expect(media.createDate, DateTime(2018, 4, 13, 7, 14, 51));
      expect(media.user?.username, 'giphy');
      expect(media.user?.displayName, 'GIPHY');
      expect(media.user?.verified, isTrue);

      final original = media.images.original!;
      expect(original.gifUrl,
          'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/giphy.gif');
      expect(original.webPUrl,
          'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/giphy.webp');
      expect(original.mp4Url,
          'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/giphy.mp4');
      expect(
          (original.width, original.height, original.frames), (480, 320, 24));
      expect(original.renditionType, GiphyRendition.original);
      expect(media.images.fixedWidth?.width, 200);
      expect(media.images.fixedWidth?.renditionType, GiphyRendition.fixedWidth);
    });

    test('parses a clip sent by the native side', () {
      final media = GiphyMedia.fromJson(clipFromNative);

      expect(media.type, GiphyMediaType.video);
      expect(media.isVideo, isTrue);
      expect(media.video?.duration, 7.5);
      expect(media.video?.hlsManifestURL,
          'https://media.giphy.com/media/r75Lktvei1JabWQB3o/hls.m3u8');
      final asset = media.video?.assets?.size360p;
      expect(asset?.url,
          'https://media.giphy.com/media/r75Lktvei1JabWQB3o/360p.mp4');
      // The native side may send asset dimensions as strings.
      expect((asset?.width, asset?.height), (640, 360));
    });

    // GiphyMediaView(media:) and GiphyVideoView(media:) send media back with toJson.
    // The fixtures lack most renditions, as real media often do.
    test('keeps its fields when sent back to the native side', () {
      for (final fixture in [gifFromNative, clipFromNative]) {
        final media = GiphyMedia.fromJson(fixture);
        final sentBack = GiphyMedia.fromJson(media.toJson());

        // aspectRatio and isVideo aren't sent: the native SDK derives them
        // from the images and the type.
        expect(sentBack.id, media.id);
        expect(sentBack.type, media.type);
        expect(sentBack.rating, media.rating);
        expect(sentBack.title, media.title);
        expect(sentBack.tags, media.tags);
        expect(sentBack.createDate, media.createDate);
        expect(sentBack.user?.username, media.user?.username);
        expect(sentBack.images.original?.gifUrl, media.images.original?.gifUrl);
        expect(sentBack.images.original?.width, media.images.original?.width);
        expect(sentBack.images.original?.renditionType,
            media.images.original?.renditionType);
        expect(sentBack.video?.duration, media.video?.duration);
        expect(sentBack.video?.assets?.size360p?.url,
            media.video?.assets?.size360p?.url);
      }
    });
  });
}
