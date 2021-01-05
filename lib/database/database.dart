import 'package:floor/floor.dart';
import 'package:new_moedah_app/dao/cartDao.dart';
import 'package:new_moedah_app/entity/cart.dart';


//Need import
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; //generate code!


 
@Database(version:1,entities: [Cart])
abstract class AppDatabase extends FloorDatabase {
  CartDao get cartDao;
}
