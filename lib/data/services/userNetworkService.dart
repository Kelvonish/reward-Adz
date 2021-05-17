import 'dart:convert';

class UserNetworkService {
  Future createUser(
      String email, String phonenumber, String country, String password) async {
    Map data = {
      'name': email,
      "password": password,
      "phone": phonenumber,
      "country": country,
      "type": "Email"
    };

    var body = json.encode(data);
    print(body);
  }
}
