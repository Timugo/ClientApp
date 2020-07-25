//flutter dependencies
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'package:timugo/globals.dart' as globals;
import 'dart:convert';
// Preferences
import 'package:timugo/src/preferencesUser/preferencesUser.dart';

final String urlBase = globals.url;
final String urlBase2 = globals.urlV2;

/* 
  Class that contains the  login services
*/
class LoginServices {
  
  final prefs = PreferenciasUsuario();

  //Methods

  /*
    Sign Up user
  */
  Future<http.Response> singUp(int phone, String name ,String email,String method, String publicityMethods ) async {
    // URL
    final String url = urlBase2 + 'user/signup?method=$method';
    /* Headers */
    Map<String, String> headers = {"Content-Type": "application/json"};
    /* Body */
    var data = { "name": name,"phone": phone,"email":email,"publicityMethod":publicityMethods};
    final body = json.encode(data);
    // making  POST request
    return await http.post(url, headers: headers, body: body);
  }

  /*
    Get all User data with the user phone
  */
  Future<Map<String, dynamic>> getUserInfo(String phone) async {
    var _urlcode = urlBase + 'getUser?phone=' + phone;
    http.Response response = await http.get(_urlcode);
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      //POST request (Need to be improved, servives only returns a https requests)
      if (decodeData['response'] == 2) {
        print(decodeData['content']);
        prefs.name = decodeData['content']['name'].toString();
        prefs.pts = decodeData['content']['points'].toString();
        prefs.id = decodeData['content']['id'].toString();
        prefs.email = decodeData['content']['email'].toString();
      }
      return decodeData;
    } else {
      throw Exception('Failed to load post');
    }
  }

  /*
    Function to login the user with facebook account
    and return the user data
  */
  Future<String> getFacebookToken() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    var returnValue ;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        returnValue = result.accessToken.token;
        break;
      case FacebookLoginStatus.cancelledByUser:
        returnValue = "cancelled";
        break;
      case FacebookLoginStatus.error:
        returnValue =  "error";
        break;
    }
    return returnValue;
  }

  /*
    This function get all data from Facebook user
  */
  Future<http.Response> getFacebookData(String token) async {
    return await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  }

  /*
    Function to login the user with Apple account
    and return the user data
  */
  Future<AuthorizationCredentialAppleID> appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    return credential;
    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
    
  }
  
  Future<Map<String, dynamic>> checkLogin(String method, String phone ,String email) async {
    var _urlcode = urlBase2 + 'user/register/status?method=$method&phone=$phone&email=$email' + prefs.order;
    http.Response response = await http.get(_urlcode);
    final decodeData = json.decode(response.body);
    if (decodeData['response'] == 1) {
      prefs.order = '0';
    }

    return decodeData;
  }
}
