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
  Future<String?> login(String email, String password) async {
    try {
      // POST request to backend
      final response = await _dio.post(
        '$baseUrl/login',
        data: {'email': email, 'password': password},
        // options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // If (200 OK), parse payloads and extract tokens
      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        // Encrypt and save tokens locally
        await _secureStorage.write(key: 'access_token', value: accessToken);
        await _secureStorage.write(key: 'refresh_token', value: refreshToken);
        return null; // Return null if no error occurred
      }
      return 'Unexpected authentication response.';
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) return 'Too many request.';
      if (e.response?.statusCode == 401) return 'Invalid email or password.';
      return e.message ?? 'An unknown connection error occurred.';
    }
  }

  // Register new user
  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      // POST request to backend
      final response = await _dio.post(
        '$baseUrl/resgiter',
        data: {'username': username, 'email': email, 'password': password},
        // options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) return null; // Success
      return 'Registration failed.';
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['error'] != null) {
        return e.response?.data['error'];
      }
      return 'Failed to reach registration server.';
    }
  }

  // Evaluate whether an access token exists to skip login on app startup
  Future<bool> hasValidSession() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null;
  }

  // Wipe tokens when user logs out
  Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }
}
