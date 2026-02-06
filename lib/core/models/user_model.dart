class UserModel {
  final int? id;
  final String name;
  final String email;
  final String profilePic;
  final bool isDarkMode;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.profilePic = '',
    this.isDarkMode = false,
  });

  // Convertit un UserModel en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'isDarkMode': isDarkMode ? 1 : 0, // SQLite ne gère pas les booléens
    };
  }

  // Crée un UserModel à partir d'un Map SQLite
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
      isDarkMode: map['isDarkMode'] == 1,
    );
  }

  // Pour mettre à jour facilement un champ
  UserModel copyWith({String? name, String? email, bool? isDarkMode}) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
