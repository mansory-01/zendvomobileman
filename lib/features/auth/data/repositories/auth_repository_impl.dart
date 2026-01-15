import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // TODO: Inject RemoteDataSource & LocalDataSource

  @override
  Future<Either<Failure, void>> verifyPhone(String phoneNumber) async {
    try {
      // TODO: Implement remote call
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOTP(
    String phoneNumber,
    String otp,
  ) async {
    try {
      // TODO: Implement remote call
      const user = User(id: '1', phoneNumber: 'phoneNumber_placeholder');
      return const Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // TODO: Implement local/remote logout
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
