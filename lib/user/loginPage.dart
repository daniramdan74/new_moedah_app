import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/manajemen/manajemenPage.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';
import 'package:new_moedah_app/user/signupPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _showPassword = false;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;

  Widget _buildPasswordField(String label) {
    return TextFormField(
      controller: passwordController,
      obscureText: !this._showPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye,
                color: this._showPassword ? Colors.blueAccent : Colors.grey),
            onPressed: () {
              setState(() => _showPassword = !this._showPassword);
            }),
      ),
    );
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'close',
        onPressed: () {},
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      )),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Login to Your Account",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: mailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.mail_outline,
                                color: Colors.blueAccent,
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Email'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildPasswordField('Password'),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(''),
                              Text(
                                _isLoading ? 'Loging...' : 'Sign In',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                          color: Colors.blueAccent,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          onPressed: _isLoading ? null : _login,
                        ),
                        SizedBox(height: 40),
                        Center(
                            child: Column(
                          children: <Widget>[
                            Text(
                              '- Or Sign In With -',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FloatingActionButton(
                                backgroundColor: Colors.white,
                                child: Image.asset('assets/images/google.png'),
                                onPressed: () {}),
                            SizedBox(
                              height: 120,
                            ),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Don`t have an account ?'),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpPage()));
                                  },
                                  child: Text('SignUp',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )),
                          ],
                        ))
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': mailController.text,
      'password': passwordController.text,
    };
    var res = await ApiService().postData(data, 'login');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacementNamed(context, Routes.manajemen);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ManajemenPage()),
          (route) => false);

      // Navigator.push(context,
      // MaterialPageRoute(builder: (context)=>HomeNavBar()));
      // print(user['id']);
      print('login is successful');
    } else {
      _showMsg(body['message']);
    }
    // print(body);
    setState(() {
      _isLoading = false;
    });
  }
}
