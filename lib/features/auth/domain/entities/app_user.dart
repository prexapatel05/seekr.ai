class AppUser {
  final String uid;
  final String email;

 //CONSTRCUTOR 
  AppUser({required this.uid, required this.email});
  //CONVERT APP USER TO JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }
  //CONVERT JSON TO APP USER
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      email: json['email'],
    );
  }
}