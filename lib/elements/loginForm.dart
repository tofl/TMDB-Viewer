import 'package:flutter/material.dart';
import '../homepage.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool wrongCredentials = false;

  Color emailBorderColor = Colors.transparent;
  Color passwordBorderColor = Colors.transparent;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: wrongCredentials,
            child: Text(
              'Wrong email or password.',
              style: TextStyle(color: Colors.red),
            ),
          ),
          Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          // Username
          Padding(
            padding: EdgeInsets.only(left: 0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: emailBorderColor),
                borderRadius: new BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email address',
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
          ),

          // Password
          Padding(
            padding: EdgeInsets.only(left: 0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: passwordBorderColor),
                borderRadius: new BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
          ),

          // Submit button
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                bool hasError = false;
                if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(emailController.text)) {
                  this.emailBorderColor = Colors.red;
                  hasError = true;
                }
                if (passwordController.text == '') {
                  this.passwordBorderColor = Colors.red;
                  hasError = true;
                }

                if (hasError) {
                  return;
                }

                // Check credentials
                if (emailController.text != 'email@ynov.com' || passwordController.text != 'test') {
                  // Wrong credentials
                  print('wrong credentials');
                  setState(() {
                    wrongCredentials = true;
                  });
                  return;
                }

                setState(() {
                  wrongCredentials = false;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}