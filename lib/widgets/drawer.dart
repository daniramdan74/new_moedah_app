import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(userData != null ? '${userData['name']}' : ''),
              accountEmail: Text(
                userData != null ? '${userData['email']}' : '',
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/logo.png'),
              )),
          _createDrawerItem(
              icon: Icons.widgets,
              text: 'Manajemen',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.manajemen)),
          _createDrawerItem(
              icon: Icons.swap_vertical_circle,
              text: 'Transaction',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.transaction)),
          _createDrawerItem(
              icon: Icons.description,
              text: 'Report',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.report)),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Setting',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.setting)),
          Divider(),
          _createDrawerItem(
              icon: Icons.face,
              text: 'Authors',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.author)),
          Divider(),
          ListTile(
            title: Text('Version 0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// Widget _createHeader() {

//   return UserAccountsDrawerHeader(
//       accountName: Text('user'), accountEmail: Text(
//                                     userData != null
//                                         ? '${userData['name']}'
//                                         : '',),
//       currentAccountPicture: CircleAvatar(
//         backgroundColor: Colors.white,
//         child: FlutterLogo(size: 40.0,),
//       ),);

// }

// Widget _createHeader() {
//   return DrawerHeader(
//       margin: EdgeInsets.zero,
//       padding: EdgeInsets.zero,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             fit: BoxFit.cover,
//             image: NetworkImage(
//                 'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200')),
//       ),
//       child: Stack(children: <Widget>[
//         Positioned(
//             bottom: 12.0,
//             left: 16.0,
//             child: Text("Flutter Step-by-Step",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w500))),
//       ]));
// }

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
