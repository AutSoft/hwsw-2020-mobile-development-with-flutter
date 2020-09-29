import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var _emailValid = true;
  var _passwordValid = true;

  Future<void> _tryLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    // TODO Implement Firebase login
  }

  Future<void> _tryRegistration() {
    // TODO Implement Firebase user registration
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterForum"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.forum,
                      color: Colors.blue,
                      size: 120,
                    ),
                  ],
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Email address",
                      errorText: _emailValid
                          ? null
                          : "Please provide a valid email address"),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Password",
                    errorText: _passwordValid
                        ? null
                        : "The given password is invalid or not strong enough",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            _tryLogin();
                          },
                          child: Text("Login".toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            _tryRegistration();
                          },
                          child: Text("Register".toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
