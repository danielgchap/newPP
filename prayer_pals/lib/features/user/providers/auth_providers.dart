import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/providers/ppcuser_core_provider.dart';
import 'package:prayer_pals/features/user/clients/auth_client.dart';
import 'package:prayer_pals/features/user/repositories/auth_repository.dart';
import 'package:prayer_pals/core/utils/constants.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authClientProvider).authStateChange;
});

final authControllerProvider =
    Provider.autoDispose((ref) => AuthController(ref.read));

class AuthController {
  final Reader reader;

  AuthController(this.reader);

  signInUser({
    required String emailAddress,
    required String password,
    required Function(String success) callback,
  }) async {
    final srvMsg = await reader(authRepositoryProvider)
        .signIn(emailAddress: emailAddress, password: password);
    await reader(ppcUserCoreProvider).setupPPUserListener();
    callback(srvMsg);
  }

  signUpNewUser(
      {required String username,
      required String emailAddress,
      required String password,
      required Function(String success) callback}) async {
    final srvMsg = await reader(authRepositoryProvider).signUp(
        username: username, emailAddress: emailAddress, password: password);
    await reader(ppcUserCoreProvider).setupPPUserListener();
    callback(srvMsg);
  }

  editUser(
      {required String username,
      required String emailAddress,
      required String password,
      required Function(String success) callback}) async {
    final srvMsg = await reader(authRepositoryProvider).signUp(
        username: username, emailAddress: emailAddress, password: password);
    callback(srvMsg);
  }

  Future<String> sendForgotPasswordLink({required String emailAddress}) async {
    final srvMsg = await reader(authRepositoryProvider)
        .forgotPassword(emailAddress: emailAddress);
    if (srvMsg == StringConstants.success) {
      return StringConstants.aPasswordResetEmailWasSent;
    }
    return srvMsg;
  }
}
