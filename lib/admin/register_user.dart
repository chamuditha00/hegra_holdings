import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hegra_holdings/controller/register_controller.dart';
import 'package:hegra_holdings/models/user_model.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/images/mainlogo.png'),
                  height: 100,
                  width: 300,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Register new Employee',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.name,
                        decoration: InputDecoration(
                            label: Text('Name'),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Colors.black))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.email,
                        decoration: InputDecoration(
                            label: Text('E-mail'),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Colors.black))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.password,
                        decoration: InputDecoration(
                            label: Text('password'),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Colors.black))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.position,
                        decoration: InputDecoration(
                            label: Text('Position'),
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Colors.black))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.area,
                        decoration: InputDecoration(
                            label: Text('Area of work'),
                            prefixIcon: Icon(
                              Icons.area_chart_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: Colors.black))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final user = UserModel(
                                position: controller.position.text.trim(),
                                name: controller.name.text.trim(),
                                email: controller.email.text.trim(),
                                password: controller.password.text.trim(),
                                area: controller.area.text.trim());

                            RegisterController.instance.createUser(user);
                            RegisterController.instance.registerUser(
                                controller.email.text.trim(),
                                controller.password.text.trim());

                            // Reset the form fields after sending data
                            _formKey.currentState?.reset();
                          },
                          child: Text('Register'),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
