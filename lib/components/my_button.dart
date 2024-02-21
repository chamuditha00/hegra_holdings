import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;

  const MyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('LOGIN'),
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: Color.fromARGB(255, 52, 65, 133),
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
