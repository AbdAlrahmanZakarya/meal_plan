class CompanyModel {
  final String id;
  final String companyName;
  final String description;
  final String startingPrice;
  final String imageUrl;
  final String logoUrl;
  final Map<String, dynamic> social;

//<editor-fold desc="Data Methods">

  const CompanyModel({
    required this.id,
    required this.companyName,
    required this.description,
    required this.startingPrice,
    required this.imageUrl,
    required this.logoUrl,
    required this.social,
  });

  @override
  String toString() {
    return 'CompanyModel{ id: $id, companyName: $companyName, description: $description, startingPrice: $startingPrice, imageUrl: $imageUrl, logoUrl: $logoUrl, social: $social,}';
  }

  CompanyModel copyWith({
    String? id,
    String? companyName,
    String? description,
    String? startingPrice,
    String? imageUrl,
    String? logoUrl,
    Map<String, dynamic>? social,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      startingPrice: startingPrice ?? this.startingPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      social: social ?? this.social,
    );
  }

  Map<String, dynamic> toMap() {
    // Map<String, String> socialMap = {};
    // for (Social element in social) {
    //   socialMap[element.type.name] = element.url;
    // }

    return {
      'id': id,
      'companyName': companyName,
      'description': description,
      'startingPrice': startingPrice,
      'imageUrl': imageUrl,
      'logoUrl': logoUrl,
      'social': social,
    };
    // data['social'] = social.map((v) => v.toMap()).toList();
    // return data;
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map, String id) {
    // List<Social> socialList = [];
    // (map['social'] as Map<String, String>?)?.forEach((key, value) {
    //   socialList.add(Social(type: SocialType.values.byName(key), url: value));
    // });

    // List<Social> social = [];
    // if (map['social'] != null &&
    //     (map['social'] as Map<String, String>).isNotEmpty) {
    //   map['social'].forEach((v) {
    //     social.add(Social.fromMap(v));
    //   });
    // }

    return CompanyModel(
      id: id,
      companyName: map['companyName'] as String,
      description: map['description'] as String,
      startingPrice: map['startingPrice'] as String,
      imageUrl: map['imageUrl'] as String,
      logoUrl: map['logoUrl'] as String,
      social: map['social'] as Map<String, dynamic>,
    );
  }
//</editor-fold>
}

// enum SocialType {
//   twitter,
//   webSite,
//   phoneNumber,
//   whatsappNumber,
//   facebook,
// }

// class Social {
//   final SocialType type;
//   final String url;
//
//   const Social({
//     required this.type,
//     required this.url,
//   });
// }
