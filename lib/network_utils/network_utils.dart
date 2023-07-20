// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:friends_app/constant/shared_preference_constant.dart';
import 'package:friends_app/utils/styles/k_colors.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'api.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Network {
  static String noInternetMessage = "Check your connection!";

  static getRequest(String endPoint,
      {bool requiretoken = true, bool nobaseUrl = false}) async {
    if (await isNetworkAvailable()) {
      Response response;
      var accesstoken = getStringAsync(token);
      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (requiretoken) {
        var header = {"Authorization": "Bearer $accesstoken"};
        headers.addAll(header);
      }

      print('\nURL: ${API.base}$endPoint');
      print("Headers: $headers\n");
      if (requiretoken) {
        response = await get(
            Uri.parse(nobaseUrl ? endPoint : '${API.base}$endPoint'),
            headers: headers);
      } else {
        response =
            await get(Uri.parse(nobaseUrl ? endPoint : '${API.base}$endPoint'));
      }

      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static postRequest(String endPoint, body, {bool requiretoken = true}) async {
    if (await isNetworkAvailable()) {
      var accesstoken = getStringAsync(token);
      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (requiretoken) {
        var header = {"Authorization": "Bearer $accesstoken"};
        headers.addAll(header);
      }
      print('\nURL: ${API.base}$endPoint');
      print("Headers: $headers");
      print('Request Body: ${jsonEncode(body)}\n');

      Response response = await post(Uri.parse('${API.base}$endPoint'),
          body: jsonEncode(body), headers: headers);

      //print('Response: $response');
      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static multiPartRequest(String endPoint,
      {Map<String, String>? body, file, filedName}) async {
    var accesstoken = getStringAsync(token);

    if (await isNetworkAvailable()) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${API.base}' '$endPoint'),
      )
        ..fields.addAll(body!)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken'
        })
        ..files.add(await http.MultipartFile.fromPath("image", file));
      print('Request Files: ${request.files}');

      print('Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      print('\nURL: ${API.base}$endPoint');

      print('Request Body: ${jsonEncode(body)}\n');

      Response response = await post(Uri.parse('${API.base}$endPoint'),
          body: jsonEncode(body), headers: request.headers);

      print('Response: $response');
      return response;
    } else {
      throw noInternetMessage;
    }
  }


  static handleResponse(Response response) async {
    // print("response is : ${response.body}");
    if (!await isNetworkAvailable()) {
      toast('No network available');
    } else if (response.statusCode >= 200 && response.statusCode <= 210) {
      print('\nSuccessCode: ${response.statusCode}');
      print('SuccessResponse: ${response.body}\n');

      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      } else {
        return response.body;
      }
    } else {
      print('\nErrorCode: ${response.statusCode}');
      print("ErrorResponse: ${response.body}\n");

      if (response.statusCode == 403) {
        /// Session expired
        toast(
          "${jsonDecode(response.body)['message']}",
          bgColor: KColor.red,
        );

        setValue(isLoggedIn, false);
      } else if (response.statusCode == 422) {
        /// Custom validation message
        toast(
          '${jsonDecode(response.body)['message']}',
          bgColor: KColor.red,
        );
      } else if (response.statusCode == 429) {
        /// Too many attempts message
        toast(
          '${jsonDecode(response.body)['message']}',
          bgColor: KColor.red,
        );
      } else if (response.statusCode == 402) {
        /// Custom validation message
        toast(
          '${jsonDecode(response.body)['messages']}',
          bgColor: KColor.red,
        );
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        /// Custom message
        if (jsonDecode(response.body)['message'] == "Unauthenticated.") {
          toast('Login to continue...', bgColor: KColor.red);

          // setValue(LOGGED_IN, false);
          // NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (_) => LoginScreen()));
        } else {
          toast('${jsonDecode(response.body)['message']}', bgColor: KColor.red);
        }
        if (jsonDecode(response.body)['unverified'] != null) {
          if (jsonDecode(response.body)['unverified']) {
            if (response.body.isNotEmpty) return json.decode(response.body);
          }
        }
      } else {
        toast('Something went wrong!', bgColor: KColor.red);
      }
    }
  }
}
