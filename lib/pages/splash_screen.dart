import 'package:flutter/material.dart';
import 'package:hegra_holdings/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(microseconds: 1600),
                  bottom: animate ? 100 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(microseconds: 2000),
                    opacity: animate ? 1 : 0,
                    child: const Image(
                        image: AssetImage('assets/images/mainlogo.png')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(microseconds: 500));
    setState(() => animate = true);
    await Future.delayed(const Duration(microseconds: 5000));
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
