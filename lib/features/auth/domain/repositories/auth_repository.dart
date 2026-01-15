import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> verifyPhone(String phoneNumber);
  Future<Either<Failure, User>> verifyOTP(String phoneNumber, String otp);
  Future<Either<Failure, void>> logout();
}
