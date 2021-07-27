import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/pages/mainPage.dart';
import 'package:practice/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username = "";
  String _password = "";
  String _status = "";

  Widget _buildUsername() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.alternate_email),
        ),
        labelText: 'Username',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return 'Username Must Be 5 Characters Minimum';
        } else {
          return null;
        }
      },
      onChanged: (value) => {_username = value},
      onSaved: (value) => {_username = value!},
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.lock),
        ),
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.length < 8) {
          return 'Password Must Be 8 Characters Minimum';
        } else {
          return null;
        }
      },
      onChanged: (value) => {_password = value},
      onSaved: (value) => {_password = value!},
    );
  }

  Login(String username, String password) async {
    var response = await Dio().get(
        'http://192.168.43.189:6969/login?username=$username&password=$password');
    if (response.data['status'] == '') {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }
    setState(() {
      _status = response.data['status'];
    });
  }

  @override
  // void initState() {
  //   SystemChrome.setEnabledSystemUIOverlays([]);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _buildUsername(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPassword(),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Login(_username, _password);
                      }
                    },
                    child: Text('Login'),
                  ),
                  Text(
                    '$_status',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have An Account?',
                        style: TextStyle(fontSize: 12, fontFamily: 'Comfortaa'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteManager.registerPage);
                        },
                        child: Text(
                          'Register!',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
