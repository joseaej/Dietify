class User {
  String? password;
  String? email;
  User(String? email_, String? password_)
      : email = email_,
        password = password_;
  @override
  bool operator ==(Object other) {
    return (email == (other as User) ? true : false);
  }
}
