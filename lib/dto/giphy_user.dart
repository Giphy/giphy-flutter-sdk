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

  factory GiphyUser.fromJson(Map<String, dynamic> json) {
    return GiphyUser(
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      avatar: json['avatar'],
      bannerUrl: json['bannerUrl'],
      bannerImage: json['bannerImage'],
      profileUrl: json['profileUrl'],
      username: json['username'] ?? '',
      displayName: json['displayName'],
      email: json['email'],
      twitter: json['twitter'],
      isPublic: json['isPublic'] ?? false,
      attributionDisplayName: json['attributionDisplayName'],
      name: json['name'],
      description: json['description'],
      aboutBio: json['aboutBio'],
      facebookUrl: json['facebookUrl'],
      twitterUrl: json['twitterUrl'],
      instagramUrl: json['instagramUrl'],
      tumblrUrl: json['tumblrUrl'],
      tiktokUrl: json['tiktokUrl'],
      youtubeUrl: json['youtubeUrl'],
      isSuppressChrome: json['isSuppressChrome'] ?? false,
      websiteUrl: json['websiteUrl'],
      websiteDisplayUrl: json['websiteDisplayUrl'],
      verified: json['verified'] ?? false,
      isStaff: json['isStaff'] ?? false,
      userType: json['userType'],
    );
  }
}
