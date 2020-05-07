class UserData {
  String email;
  String displayName;
  String phoneNumber;
  String photoURL;
  String birthday;
  UserData({
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoURL,
    this.birthday,
  });
  factory UserData.fromMap(Map<dynamic, dynamic> data) {
    return UserData(
      email: data['email'],
      displayName: data['displayName'],
      phoneNumber: data['phoneNumber'],
      photoURL: data['photoURL'],
      birthday: data['birthday'],
    );
  }

  @override
  String toString() {
    return "$email\n$displayName\n$phoneNumber\n$photoURL\n$birthday";
  }
}
