import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hegra_holdings/admin/register_user.dart';
import 'package:hegra_holdings/expection/register_email_password_fail.dart';
import 'package:hegra_holdings/pages/home_page.dart';
import 'package:hegra_holdings/pages/login_page.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();
  //varible
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user != null ? Get.offAll(() => LoginPage()) : Get.offAll(() => HomePage());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(firebaseUser.value);
      if (firebaseUser.value == null) {
        Get.offAll(() => const SignUpScreen());
      } else {
        Get.offAll(() => HomePage());
      }
    } on FirebaseAuthException catch (e) {
      final ex = RegisterEmailPasswordFail.code(e.code);
      print("Error orginal: {$ex}");
      throw ex;
    } catch (_) {
      const ex = RegisterEmailPasswordFail();
      print("Error: {$ex}");
      throw ex;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {}
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {}
  }
}
