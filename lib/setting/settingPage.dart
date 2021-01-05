import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';
import 'package:new_moedah_app/user/profilePage.dart';
import 'package:new_moedah_app/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => AboutMe()));
                })
          ],
          title: Text('Settings'),
          elevation: 1,
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        drawer: AppDrawer(),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      child: Icon(
                    Icons.assessment,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text(
                      //   userData != null
                      //       ? '${userData['email']}'
                      //       : 'User@gmail.com',
                      // ),
                      Text('Version 0.0.1 Beta *Database Version 13.0')
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                trailing: Icon(Icons.lock),
                leading: Icon(
                  Icons.store,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Store'),
                onTap: () {},
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                trailing: Icon(Icons.lock),
                leading: Icon(
                  Icons.data_usage,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Database'),
                onTap: () {},
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                trailing: Icon(Icons.lock),
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('E-Wallet'),
                onTap: () {},
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                trailing: Icon(Icons.lock),
                leading: Icon(
                  Icons.sync,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Synchronization'),
                onTap: () {},
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                trailing: Icon(Icons.lock),
                leading: Icon(
                  Icons.print,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Print and Receipt'),
                onTap: () {},
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                trailing: Icon(Icons.lock),
                leading: Icon(
                  Icons.phonelink_erase,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Reset All Data'),
                onTap: () {},
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                leading: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Logout'),
                onTap: () {
                  logout(context);
                },
              ),
              Divider(height: 10, thickness: 1),
            ],
          ),
        ));
  }

  void logout(BuildContext context) async {
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
}
