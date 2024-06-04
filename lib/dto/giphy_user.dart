/// A class representing a user on Giphy.
class GiphyUser {
  /// The unique identifier of the user.
  final String? id;

  /// The URL of the user's avatar.
  final String? avatarUrl;

  /// An alternative avatar property.
  final String? avatar;

  /// The URL of the user's banner.
  final String? bannerUrl;

  /// An alternative banner image property.
  final String? bannerImage;

  /// The URL of the user's profile.
  final String? profileUrl;

  /// The username of the user. This is required.
  final String username;

  /// The display name of the user.
  final String? displayName;

  /// The email address of the user.
  final String? email;

  /// The Twitter handle of the user.
  final String? twitter;

  /// Whether the user's profile is public.
  final bool isPublic;

  /// Attribution display name
  final String? attributionDisplayName;

  /// Name
  final String? name;

  /// A textual description of the user.
  final String? description;

  /// A short biography of the user.
  final String? aboutBio;

  /// The Facebook profile URL of the user.
  final String? facebookUrl;

  /// The Twitter profile URL of the user.
  final String? twitterUrl;

  /// The Instagram profile URL of the user.
  final String? instagramUrl;

  /// The Tumblr profile URL of the user.
  final String? tumblrUrl;

  /// The TikTok profile URL of the user.
  final String? tiktokUrl;

  /// The YouTube channel URL of the user.
  final String? youtubeUrl;

  /// Supress chrome
  final bool isSuppressChrome;

  /// The user's website URL.
  final String? websiteUrl;

  /// The display URL for the user's website.
  final String? websiteDisplayUrl;

  /// Whether the user is verified.
  final bool verified;

  /// Whether the user is a staff member.
  final bool isStaff;

  /// The type of user.
  final String? userType;

  /// Constructor for creating a [GiphyUser] instance.
  const GiphyUser({
    this.id,
    this.avatarUrl,
    this.avatar,
    this.bannerUrl,
    this.bannerImage,
    this.profileUrl,
    required this.username,
    this.displayName,
    this.email,
    this.twitter,
    this.isPublic = false,
    this.attributionDisplayName,
    this.name,
    this.description,
    this.aboutBio,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.tumblrUrl,
    this.tiktokUrl,
    this.youtubeUrl,
    this.isSuppressChrome = false,
    this.websiteUrl,
    this.websiteDisplayUrl,
    this.verified = false,
    this.isStaff = false,
    this.userType,
  });

  /// Converts the [GiphyUser] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatarUrl': avatarUrl,
      'avatar': avatar,
      'bannerUrl': bannerUrl,
      'bannerImage': bannerImage,
      'profileUrl': profileUrl,
      'username': username,
      'displayName': displayName,
      'email': email,
      'twitter': twitter,
      'isPublic': isPublic,
      'attributionDisplayName': attributionDisplayName,
      'name': name,
      'description': description,
      'aboutBio': aboutBio,
      'facebookUrl': facebookUrl,
      'twitterUrl': twitterUrl,
      'instagramUrl': instagramUrl,
      'tumblrUrl': tumblrUrl,
      'tiktokUrl': tiktokUrl,
      'youtubeUrl': youtubeUrl,
      'isSuppressChrome': isSuppressChrome,
      'websiteUrl': websiteUrl,
      'websiteDisplayUrl': websiteDisplayUrl,
      'verified': verified,
      'isStaff': isStaff,
      'userType': userType,
    };
  }

  /// Creates a [GiphyUser] instance from a JSON map.
  factory GiphyUser.fromJson(Map<Object?, Object?> json) {
    return GiphyUser(
      id: json['id'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      avatar: json['avatar'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      bannerImage: json['bannerImage'] as String?,
      profileUrl: json['profileUrl'] as String?,
      username: json['username'] as String? ?? '',
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      twitter: json['twitter'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      attributionDisplayName: json['attributionDisplayName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      aboutBio: json['aboutBio'] as String?,
      facebookUrl: json['facebookUrl'] as String?,
      twitterUrl: json['twitterUrl'] as String?,
      instagramUrl: json['instagramUrl'] as String?,
      tumblrUrl: json['tumblrUrl'] as String?,
      tiktokUrl: json['tiktokUrl'] as String?,
      youtubeUrl: json['youtubeUrl'] as String?,
      isSuppressChrome: json['isSuppressChrome'] as bool? ?? false,
      websiteUrl: json['websiteUrl'] as String?,
      websiteDisplayUrl: json['websiteDisplayUrl'] as String?,
      verified: json['verified'] as bool? ?? false,
      isStaff: json['isStaff'] as bool? ?? false,
      userType: json['userType'] as String?,
    );
  }
}
