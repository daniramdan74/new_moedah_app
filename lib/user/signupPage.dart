import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/manajemen/manajemenPage.dart';
import 'package:new_moedah_app/service/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  // SignUpPage({Key key, this.dao}) : super(key: key);
  // final CartDao dao;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;
  bool _showPassword = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.blueAccent,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
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
                      Text("Create Your Account",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.blueAccent,
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Name'),
                      ),
                      SizedBox(
                        height: 10,
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
                        height: 10,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.phone_iphone,
                              color: Colors.blueAccent,
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Phone'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(''),
                              Text(
                                _isLoading ? 'Creating...' : 'Sign Up',
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
                          onPressed: _isLoading ? null : _handleLogin),
                      SizedBox(height: 40),
                      Center(
                          child: Column(
                        children: <Widget>[
                          Text(
                            '- Or Sign Up With -',
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
                        ],
                      ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': nameController.text,
      'email': mailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordController.text,
      'phone': phoneController.text
    };
    var res = await ApiService().postData(data, 'register');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      // var userJson = localStorage.getString('user');
      // var user = json.decode(userJson);
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => ManajemenPage()));
      // print(user['id']);

    } else {
      return print('data gagal dibuat');
    }

    setState(() {
      _isLoading = false;
    });
  }
}
