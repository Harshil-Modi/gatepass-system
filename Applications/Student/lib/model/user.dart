class User {
  String id = "";
  String email = "";
  String name = "";
  String mobile = "";
  String profilePic = "";
  String token = "";
  bool isPending;
  User({
    this.id,
    this.email,
    this.name,
    this.mobile,
    this.profilePic,
    this.token,
    this.isPending,
  });
}

User user;
