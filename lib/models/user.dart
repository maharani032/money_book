class Usermodel {
  final String id;
  final String fullname;
  final String email;
  Usermodel({required this.id, required this.fullname, required this.email});
  Usermodel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullname = data['fullname'],
        email = data['email'];
  Map<String, dynamic> toJson() {
    return {'id': id, 'fullname': fullname, 'email': email};
  }
}
