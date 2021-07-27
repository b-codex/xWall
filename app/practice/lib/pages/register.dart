import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/pages/mainPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fullname = "";
  String _username = "";
  String _password = "";
  String _status = "";

  Register(String fullname, String username, String password) async {
    if (_fullname.contains(' ')) {
      _fullname.replaceAll(' ', '+');
    }
    var response = await Dio().post(
        'http://192.168.43.189:6969/register?fullname=$_fullname&username=$username&password=$password');
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

  Widget _buildFullname() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(Icons.person),
        ),
        labelText: 'Fullname',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Fullname Is Required';
        } else {
          return null;
        }
      },
      onChanged: (value) => {_fullname = value},
      onSaved: (value) => {_fullname = value!},
    );
  }

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

  // @override
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
                        'Register',
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
                  _buildFullname(),
                  SizedBox(
                    height: 10,
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
                        Register(_fullname, _username, _password);
                      }
                    },
                    child: Text('Register'),
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
                        'Already Have An Account?',
                        style: TextStyle(fontSize: 12),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login!',
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
