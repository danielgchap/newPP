import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/user/clients/auth_client.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
    (ref) => AuthRepositoryImpl(reader: ref.read));

abstract class AuthRepository {
  Future<String> signUp(
      {required String username,
      required String emailAddress,
      required String password});
  Future<String> edit(
      {required String username,
      required String emailAddress,
      required String password});
  Future<String> signIn(
      {required String emailAddress, required String password});
  Future<String> forgotPassword({required String emailAddress});
}

class AuthRepositoryImpl implements AuthRepository {
  final Reader reader;

  AuthRepositoryImpl({required this.reader});

  @override
  Future<String> signIn(
      {required String emailAddress, required String password}) {
    return reader(authClientProvider)
        .signIn(email: emailAddress, password: password);
  }

  @override
  Future<String> signUp({
    required String username,
    required String emailAddress,
    required String password,
  }) async {
    return await reader(authClientProvider)
        .signUp(username: username, email: emailAddress, password: password);
  }

  @override
  Future<String> edit({
    required String username,
    required String emailAddress,
    required String password,
  }) async {
    return await reader(authClientProvider)
        .edit(username: username, email: emailAddress, password: password);
  }

  @override
  Future<String> forgotPassword({required String emailAddress}) async {
    return await reader(authClientProvider)
        .forgotPassword(emailAddress: emailAddress);
  }
}
