class PostRegisterReq {
  String? username;
  String? password;
  String? email;
  String? name;
  String? profile;
  int? role;

  PostRegisterReq(
      {this.username,
      this.password,
      this.email,
      this.name,
      this.profile,
      this.role});

  PostRegisterReq.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    name = json['name'];
    profile = json['profile'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (username != null) {
      data['username'] = username;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (profile != null) {
      data['profile'] = profile;
    }
    if (role != null) {
      data['role'] = role;
    }
    return data;
  }
}
