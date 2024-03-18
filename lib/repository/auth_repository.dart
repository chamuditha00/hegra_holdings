import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hegra_holdings/admin/register_user.dart';
import 'package:hegra_holdings/expection/register_email_password_fail.dart';
import 'package:hegra_holdings/pages/home_page.dart';
import 'package:hegra_holdings/pages/login_page.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
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

      // No need to navigate here, the authentication state listener will handle it
      // Also, firebaseUser might not be updated immediately, so this check might not work as expected
      // Instead, let the authStateChanges handle navigation
    } on FirebaseAuthException catch (e) {
      final ex = RegisterEmailPasswordFail.code(e.code);
      print("Error original: $ex"); // corrected interpolation
      throw ex;
    } catch (_) {
      const ex = RegisterEmailPasswordFail();
      print("Error: $ex"); // corrected interpolation
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
