import 'package:flutter/material.dart';
import 'elements/loginForm.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://image.tmdb.org/t/p/w1280/TnOeov4w0sTtV2gqICqIxVi74V.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 15),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),

                  // Login form
                  LoginForm(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}