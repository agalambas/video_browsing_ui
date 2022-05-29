class User {
  final String id;
  final String name;
  final bool hasPhoto;
  User({required this.id, required this.name, this.hasPhoto = false});

  String? get photoUrl => hasPhoto ? 'assets/user_photos/$id.jpg' : null;
}
