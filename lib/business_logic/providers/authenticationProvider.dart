import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // you can add extras if you require
    ],
  );
  final facebookLogin = FacebookLogin();
  logoutSocial() async {
    await _googleSignIn.signOut();
    await facebookLogin.logOut();
  }

  googleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // you can add extras if you require
      ],
    );

    return _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
//GoogleSignInAuthentication auth = await acc.authentication;
      //print(acc.id);
      //print(acc.email);
      //print(acc.displayName);
      //print(acc.photoUrl);

      return acc;
      //acc.authentication.then((GoogleSignInAuthentication auth) async {
      //print(auth.idToken);
      //print(auth.accessToken);
      //});
    });
    //notifyListeners();
  }

  facebookSignUp(BuildContext context) async {
    // await facebookLogin.logOut();

    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        /*print("Success");
      print(result.accessToken);
      print(result.accessToken.token);
      print(result.accessToken.expires);
      print(result.accessToken.permissions);
      print(result.accessToken.userId);
      print(result.accessToken.isValid());*/
        final token = result.accessToken.token;
        var url = Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');

        /// for profile details also use the below code
        final graphResponse = await http.get(url);
        final profile = json.decode(graphResponse.body);
        if (profile != null) {
          return profile;
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        print("User cancelled");
        return null;
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        return null;
        break;
    }
  }

  twitterLogin() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: 'IL5ryrgm3qqnOECChYpKVRuUP',
      consumerSecret: 'ArXoJKeXS1u6uMr9wmDPqvmFicJnv9XcujMeSEbIuSYLM0UpwF',
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    print(result);

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        //var session = result.session;
        print(result);
        print('logged in');
        break;
      case TwitterLoginStatus.cancelledByUser:
        print("User cancelled");
        break;
      case TwitterLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }
}
