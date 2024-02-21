import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: 'E-mail',
            hintText: 'Enter your email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                width: 1,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Password',
            hintText: 'Enter your password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                width: 1,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: null,
              icon: Icon(Icons.visibility),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('LOGIN'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
