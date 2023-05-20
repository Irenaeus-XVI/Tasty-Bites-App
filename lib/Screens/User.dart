class User {
  String name;
  String email;
  String hashedPW;

  User({required this.name, required this.email, required this.hashedPW});

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getEmail() {
    return email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getHashedPW() {
    return hashedPW;
  }

  void setHashedPW(String hashedPW) {
    this.hashedPW = hashedPW;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'hashedPW': hashedPW,
      };

  factory User.fromJson(Map<String, dynamic> json) =>
      User(name: json['name'], email: json['email'], hashedPW: json['hashedPW']);
}
