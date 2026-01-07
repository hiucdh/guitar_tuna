import 'package:dio/dio.dart';
import '../../../core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  AuthRemoteDataSourceImpl({Dio? client}) : client = client ?? Dio();

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await client.post(
        'https://fakestoreapi.com/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['token'];
      } else {
        throw ServerException('Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Temporary print for debugging
      print('LOGIN ERROR: $e');
      throw ServerException(e.toString());
    }
  }
}
