import '../../main.dart';

class UserData {
  String? userId;
  String gender;
  List<String> favoriteCompanies;
  List<String> favoritePlans;
  DateTime? birthday;
  String? phone;
  String? dialCode;

  UserData({
    this.userId,
    required this.gender,
    required this.favoriteCompanies,
    required this.favoritePlans,
    this.birthday,
    this.phone,
    this.dialCode,
  });

  @override
  String toString() {
    return 'UserData{ userId: $userId, Gender: $gender, favoriteCompanies: $favoriteCompanies, favoritePlans: $favoritePlans, birthday: $birthday, phone: $phone, dialCode: $dialCode,}';
  }

  UserData copyWith({
    String? userId,
    String? gender,
    List<String>? favoriteCompanies,
    List<String>? favoritePlans,
    DateTime? birthday,
    String? phone,
    String? dialCode,
  }) {
    return UserData(
      userId: userId ?? this.userId,
      gender: gender ?? this.gender,
      favoriteCompanies: favoriteCompanies ?? this.favoriteCompanies,
      favoritePlans: favoritePlans ?? this.favoritePlans,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      dialCode: dialCode ?? this.dialCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'favoriteCompanies': favoriteCompanies,
      'favoritePlans': favoritePlans,
      'birthday': birthday,
      'phone': phone,
      'dialCode': dialCode,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map, String id) {
    return UserData(
      userId: id,
      gender: map['gender'],
      favoriteCompanies: List<String>.from(map['favoriteCompanies']),
      favoritePlans: List<String>.from(map['favoritePlans']),
      birthday: DateTime.parse(map['birthday']),
      phone: map['phone'],
      dialCode: map['dialCode'],
    );
  }

  Future<void> saveToPrefs() async {
    try {
      await prefs.setString('userId', userId ?? '');
      await prefs.setString('gender', gender);
      await prefs.setString('phone', phone ?? '');
      await prefs.setString('dialCode', dialCode ?? '');
      await prefs.setString('birthday', birthday?.toIso8601String() ?? '');
      await prefs.setStringList('favoriteCompanies', favoriteCompanies);
      await prefs.setStringList('favoritePlans', favoritePlans);
    } catch (e) {
      //
    }
  }

//</editor-fold>
}
