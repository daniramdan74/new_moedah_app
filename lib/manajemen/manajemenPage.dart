import 'package:flutter/material.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/widgets/drawer.dart';

class ManajemenPage extends StatefulWidget {
  static const String routeName = '/manajemen';
  @override
  _ManajemenPageState createState() => _ManajemenPageState();
}

class _ManajemenPageState extends State<ManajemenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Management'),
          elevation: 1,
        ),
        drawer: AppDrawer(),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.fastfood,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Product'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.product);
                },
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                leading: Icon(
                  Icons.apps,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Category'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.category);
                },
              ),
              Divider(height: 10, thickness: 1),
              ListTile(
                trailing: Icon(Icons.lock),
                leading: Icon(
                  Icons.local_offer,
                  color: Theme.of(context).primaryColor,
                  size: 30.0,
                ),
                title: Text('Pajak'),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              Divider(height: 10, thickness: 1),
            ],
          ),
        ));
  }
}
