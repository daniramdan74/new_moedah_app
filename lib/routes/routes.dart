import 'package:new_moedah_app/manajemen/category/categoryPage.dart';
import 'package:new_moedah_app/manajemen/manajemenPage.dart';
import 'package:new_moedah_app/manajemen/product/productPage.dart';

import 'package:new_moedah_app/report/reportPage.dart';
import 'package:new_moedah_app/setting/settingPage.dart';
import 'package:new_moedah_app/transaction/transactionPage.dart';
import 'package:new_moedah_app/user/author.dart';
import 'package:new_moedah_app/user/loginPage.dart';

class Routes {
  static const String manajemen = ManajemenPage.routeName;
  static const String transaction = TransactionPage.routeName;
  static const String report = ReportPage.routeName;
  static const String setting = SettingPage.routeName;
    static const String author = AuthorPage.routeName;
  
  static const String product = ProductPage.routeName;
  
  static const String category = CategoryPage.routeName;

    static const String login = LoginPage.routeName;
// static const String addEditCategory = AddEditCategogryPage.routeName;
  
}