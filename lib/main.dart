import 'package:flutter/material.dart';
import 'package:new_moedah_app/dao/cartDao.dart';
import 'package:new_moedah_app/database/database.dart';
import 'package:new_moedah_app/manajemen/category/categoryPage.dart';
import 'package:new_moedah_app/manajemen/manajemenPage.dart';
import 'package:new_moedah_app/manajemen/product/productPage.dart';
import 'package:new_moedah_app/report/reportPage.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/setting/settingPage.dart';
import 'package:new_moedah_app/transaction/cartDetail.dart';
import 'package:new_moedah_app/transaction/transactionDetailPage.dart';
import 'package:new_moedah_app/transaction/transactionPage.dart';
import 'package:new_moedah_app/user/author.dart';
import 'package:new_moedah_app/user/loginPage.dart';
import 'package:new_moedah_app/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  // statusBarIconBrightness: Brightness.light,
  // statusBarBrightness: Brightness.light));
  final database =
      await $FloorAppDatabase.databaseBuilder('edmt_cart_system.db').build();
  final dao = database.cartDao;

  runApp(MyApp(dao: dao));
}

class MyApp extends StatefulWidget {
  final CartDao dao;
  MyApp({this.dao});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    _checkIfLoogedIn();
    super.initState();
  }

  void _checkIfLoogedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    print(token);
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            body: _isLoggedIn ? ManajemenPage() : LoginPage(),
            drawer: Padding(
              padding: EdgeInsets.all(0.0), 
              // padding: MediaQuery.of(context).padding,
              child: AppDrawer())),
        routes: {
          Routes.manajemen: (context) => ManajemenPage(),
          Routes.transaction: (context) => TransactionPage(dao: widget.dao),
          Routes.report: (context) => ReportPage(),
          Routes.setting: (context) => SettingPage(),
          Routes.product: (context) => ProductPage(),
          Routes.category: (context) => CategoryPage(),
          Routes.login: (context) => LoginPage(),
          Routes.author: (context) => AuthorPage(),
          "/cart": (context) => CartDetail(
                cartDao: widget.dao,
              ),
          "/transactionPay": (context) => TransactionDetailPage(
                cartDao: widget.dao,
              )
        });
  }
}

// class MyHomePage extends StatefulWidget {

//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: SafeArea(child: AppDrawer())

//     );

//   }
// }
