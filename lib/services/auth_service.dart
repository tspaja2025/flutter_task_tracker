import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Initialize DIo and Secure Storate clients
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Base URL config
  String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080'; // Android loopback
    }
    return 'http://localhost:8080'; // IOS, Web and Desktop
  }

  // Send login credentials to the API and secure the returning JWT
  Future<bool> login(String email, String password) async {
    try {
      // POST request to backend
      final response = await _dio.post(
        '$baseUrl/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // If (200 OK), parse payloads and extract tokens
      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        // Encrypt and save tokens locally
        await _secureStorage.write(key: 'access_token', value: accessToken);
        await _secureStorage.write(key: 'refresh_token', value: refreshToken);

        print('Login Succesful! Tokens secured.');
        return true;
      }

      return false;
    } on DioException catch (e) {
      // Backend protections
      if (e.response?.statusCode == 429) {
        print(
          'Error: Rate limit exceeded! Backend response: ${e.response?.data["error"]}',
        );
      } else if (e.response?.statusCode == 401) {
        print('Error: Invalid credentials.');
      } else {
        print('Network error: ${e.message}');
      }
      return false;
    }
  }

  // Grap access token for making protected /tasks call
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  // Wipe tokens when user logs out
  Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }
}