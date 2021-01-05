import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showPassword = false;
  bool _showCPassword = false;
  var userData;

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    print(user);
    setState(() {
      userData = user;
      nameController.value = TextEditingValue(
          text: userData != null ? '${userData['name']}' : 'unkonwn');
      mailController.value = TextEditingValue(
          text: userData != null ? '${userData['email']}' : 'unkonwn');
      phoneController.value = TextEditingValue(
          text: userData != null ? '${userData['phone']}' : 'unkonwn');
    });
  }

  // @override
  // void setState(fn) {
  //   nameController.value = TextEditingValue(
  //       text: userData != null ? '${userData['phone']}' : 'ashdjkashdk');
  //   super.setState(fn);
  // }

  Widget _buildPasswordField(String label) {
    return TextField(
      controller: passwordController,
      obscureText: !this._showPassword,
      decoration: InputDecoration(
        hintText: 'New Password',
        labelText: label,
        suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye,
                color: this._showPassword ? Colors.blue : Colors.grey),
            onPressed: () {
              setState(() => _showPassword = !this._showPassword);
            }),
      ),
    );
  }

  Widget _buildCPasswordField(String label) {
    return TextField(
      controller: cPasswordController,
      obscureText: !this._showCPassword,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        labelText: label,
        suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye,
                color: this._showCPassword ? Colors.blue : Colors.grey),
            onPressed: () {
              setState(() => _showCPassword = !this._showCPassword);
            }),
      ),
    );
  }

  void _handleUpdateProfile() async {
    var data = {
      'name': nameController.text,
      'email': mailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordController.text,
      'phone': phoneController.text,
    };
    // print(data);
    var res = await ApiService().updateDataProfile(data, 'update');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 200) {
      // Navigator.pushReplacementNamed(context, Routes.product);
      logout();
      return print('data berhasil diubah');
    } else {
      return print('gagal diubah');
    }
  }

  void logout() async {
    //logout from the server
    var res = await ApiService().getData('logout');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacementNamed(context, Routes.login);
      //  Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => LoginPage()),
      //     (route) => false);

      print(body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text('Profile'),
          elevation: 1,
        ),
        backgroundColor: Colors.grey[200],
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: <Widget>[
                Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200'))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.blueAccent),
                              child: Icon(Icons.edit, color: Colors.white))),
                    ],
                  ),
                ),

                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: mailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ////////password field///////
                _buildPasswordField('Password'),
                SizedBox(
                  height: 10,
                ),
                ////////password field///////
                _buildCPasswordField('Confirm Password'),
                SizedBox(
                  height: 80,
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('Update',
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white)),
                  onPressed: () {
                    _handleUpdateProfile();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
