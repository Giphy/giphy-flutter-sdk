// Media in the format the native side sends to Dart: the SDK's media JSON with
// camelCase keys (see GPHMedia.toDictionary in the iOS plugin).

const gifFromNative = <String, Object?>{
  'id': 'LRs6P30O9lWaRjzdN0',
  'type': 'gif',
  'slug': 'test-gif-LRs6P30O9lWaRjzdN0',
  'url': 'https://giphy.com/gifs/test-gif-LRs6P30O9lWaRjzdN0',
  'title': 'Test GIF',
  'rating': 'g',
  'tags': ['test', 'gif'],
  'isSticker': false,
  'isDynamic': false,
  'isVideo': false,
  'aspectRatio': 1.5,
  'createDate': '2018-04-13T07:14:51.000',
  'user': {
    'id': '12345',
    'username': 'giphy',
    'displayName': 'GIPHY',
    'verified': true,
  },
  'images': {
    'mediaId': 'LRs6P30O9lWaRjzdN0',
    'original': {
      'gifUrl': 'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/giphy.gif',
      'webPUrl': 'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/giphy.webp',
      'mp4Url': 'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/giphy.mp4',
      'width': 480,
      'height': 320,
      'frames': 24,
      'renditionType': 'original',
      'mediaId': 'LRs6P30O9lWaRjzdN0',
    },
    'fixedWidth': {
      'gifUrl': 'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/200w.gif',
      'width': 200,
      'height': 133,
      'renditionType': 'fixedWidth',
      'mediaId': 'LRs6P30O9lWaRjzdN0',
    },
  },
};

const clipFromNative = <String, Object?>{
  'id': 'r75Lktvei1JabWQB3o',
  'type': 'video',
  'title': 'Test clip',
  'rating': 'pg',
  'isVideo': true,
  'aspectRatio': 1.778,
  'images': {
    'mediaId': 'r75Lktvei1JabWQB3o',
    'original': {
      'gifUrl': 'https://media.giphy.com/media/r75Lktvei1JabWQB3o/giphy.gif',
      'width': 480,
      'height': 270,
      'renditionType': 'original',
    },
  },
  'video': {
    'duration': 7.5,
    'hlsManifestURL':
        'https://media.giphy.com/media/r75Lktvei1JabWQB3o/hls.m3u8',
    'assets': {
      '360p': {
        'url': 'https://media.giphy.com/media/r75Lktvei1JabWQB3o/360p.mp4',
        'width': 640,
        'height': '360',
      },
    },
  },
};
