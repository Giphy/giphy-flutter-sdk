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
