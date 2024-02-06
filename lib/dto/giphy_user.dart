class GiphyUser {
  final String? id;
  final String? avatarUrl;
  final String? avatar;
  final String? bannerUrl;
  final String? bannerImage;
  final String? profileUrl;
  final String username;
  final String? displayName;
  final String? email;
  final String? twitter;
  final bool isPublic;
  final String? attributionDisplayName;
  final String? name;
  final String? description;
  final String? aboutBio;
  final String? facebookUrl;
  final String? twitterUrl;
  final String? instagramUrl;
  final String? tumblrUrl;
  final String? tiktokUrl;
  final String? youtubeUrl;
  final bool isSuppressChrome;
  final String? websiteUrl;
  final String? websiteDisplayUrl;
  final bool verified;
  final bool isStaff;
  final String? userType;

  GiphyUser({
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar_url': avatarUrl,
      'avatar': avatar,
      'banner_url': bannerUrl,
      'banner_image': bannerImage,
      'profile_url': profileUrl,
      'username': username,
      'display_name': displayName,
      'email': email,
      'twitter': twitter,
      'is_public': isPublic,
      'attribution_display_name': attributionDisplayName,
      'name': name,
      'description': description,
      'about_bio': aboutBio,
      'facebook_url': facebookUrl,
      'twitter_url': twitterUrl,
      'instagram_url': instagramUrl,
      'tumblr_url': tumblrUrl,
      'tiktok_url': tiktokUrl,
      'youtube_url': youtubeUrl,
      'suppress_chrome': isSuppressChrome,
      'website_url': websiteUrl,
      'website_display_url': websiteDisplayUrl,
      'is_verified': verified,
      'is_staff': isStaff,
      'user_type': userType,
    };
  }

  factory GiphyUser.fromJson(Map<String, dynamic> json) {
    return GiphyUser(
      id: json['id'],
      avatarUrl: json['avatar_url'],
      avatar: json['avatar'],
      bannerUrl: json['banner_url'],
      bannerImage: json['banner_image'],
      profileUrl: json['profile_url'],
      username: json['username'] ?? '',
      displayName: json['display_name'],
      email: json['email'],
      twitter: json['twitter'],
      isPublic: json['is_public'] ?? false,
      attributionDisplayName: json['attribution_display_name'],
      name: json['name'],
      description: json['description'],
      aboutBio: json['about_bio'],
      facebookUrl: json['facebook_url'],
      twitterUrl: json['twitter_url'],
      instagramUrl: json['instagram_url'],
      tumblrUrl: json['tumblr_url'],
      tiktokUrl: json['tiktok_url'],
      youtubeUrl: json['youtube_url'],
      isSuppressChrome: json['suppress_chrome'] ?? false,
      websiteUrl: json['website_url'],
      websiteDisplayUrl: json['website_display_url'],
      verified: json['is_verified'] ?? false,
      isStaff: json['is_staff'] ?? false,
      userType: json['user_type'],
    );
  }
}
