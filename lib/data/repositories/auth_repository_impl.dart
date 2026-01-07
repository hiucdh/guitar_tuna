import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final token = await remoteDataSource.login(username, password);
      return Right(User(token: token));
    } on ServerException {
      return Left(ServerFailure('Authentication failed'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
