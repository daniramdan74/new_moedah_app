import 'package:flutter/material.dart';
import 'package:new_moedah_app/widgets/drawer.dart';

class AuthorPage extends StatefulWidget {
  static const String routeName = '/author';
  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About Author'),
        ),
        drawer: AppDrawer(),
        body: Stack(children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue,
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(75),
              //     bottomRight: Radius.circular(75))
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 10),
            child: Stack(
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/author.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue),
                        child: Icon(Icons.star, color: Colors.white))),
              ],
            ),
          ),
          Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 110),
                  child: Text(
                    'Dani Ramdan',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Text(
                    'Jr. Mobile Flutter',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView(
            padding: EdgeInsets.only(top: 250, left: 20, right: 20),
            children: <Widget>[
              Card(
                elevation: 5,
                child: SizedBox(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Text('   '),
                        Icon(
                          Icons.email,
                          color: Colors.blueAccent,
                        ),
                        Text('   '),
                        Expanded(child: Text('daniramdan74@gmail.com'))
                      ],
                    )),
              ),
              Card(
                elevation: 5,
                child: SizedBox(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Text('   '),
                        Container(
                          padding: EdgeInsets.fromLTRB(1, 17, 0, 17),
                          child: Image.asset('assets/images/twitter.png'),
                        ),
                        Text('   '),
                        Expanded(child: Text('bydaniramdan'))
                      ],
                    )),
              ),
                            Card(
                elevation: 5,
                child: SizedBox(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Text('   '),
                        Container(
                          padding: EdgeInsets.fromLTRB(1, 17, 0, 17),
                          child: Image.asset('assets/images/linkedin.png'),
                        ),
                        Text('   '),
                        Expanded(child: Text('/bydaniramdan'))
                      ],
                    )),
              ),
              Card(
                elevation: 5,
                child: SizedBox(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Text('   '),
                        Container(
                          padding: EdgeInsets.fromLTRB(1, 17, 0, 17),
                          child: Image.asset('assets/images/github.png'),
                        ),
                        Text('   '),
                        Expanded(child: Text('/daniramdan74'))
                      ],
                    )),
              ),

            ],
          )
        ]));
  }
}
