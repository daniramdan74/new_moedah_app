import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:new_moedah_app/const/const.dart';
import 'package:new_moedah_app/dao/cartDao.dart';
import 'package:new_moedah_app/entity/cart.dart';
import 'package:new_moedah_app/models/mproduct.dart';
import 'package:new_moedah_app/service/apiService.dart';
import 'package:new_moedah_app/widgets/drawer.dart';
import 'package:new_moedah_app/widgets/productCard.dart';

class TransactionPage extends StatefulWidget {
  static const String routeName = '/transaction';
  TransactionPage({Key key, this.dao}) : super(key: key);
  final CartDao dao;

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("transaction"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
        future: _fetchdata(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text('${snapshot.error}'),
            );
          else if (snapshot.hasData) {
            return Padding(
                padding: EdgeInsets.all(8),
                child: GridView.count(
                    childAspectRatio: 0.7,
                    crossAxisCount: 2,
                    children: List.generate(snapshot.data.length, (index) {
                      return Center(
                        child: ProductCard(
                            cartDao: widget.dao, product: snapshot.data[index]),
                      );
                    })));
          } else {
            return Center(
              child: Text('Please Wait...'),
              
            );
          }
          // else return Center (child: CircularProgressIndicator());
        },
      ),
    floatingActionButton:   StreamBuilder(
      stream: widget.dao.getAllItemInCartByUid(uID),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var list = snapshot.data as List<Cart>;
          return Badge(
            position: BadgePosition(
              top:0, end:1
            ),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.fade,
            showBadge: true,
            badgeColor: Colors.red,
            badgeContent: Text('${
              list.length>0?list.map((m) => m.qty).reduce((value, element) => value+element)
              :0
            }',style: TextStyle(color: Colors.white),),
            child: FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(context, "/cart");
              },
              child: Icon(Icons.shopping_basket),
            ),
          );

        }
        else{
          return Container();
        }
      },
      ),
    );
  }

  // Future<List<Product>> readJSONDatabase() async {
  //   final rawData = await rootBundle.rootBundle
  //       .loadString('assets/data/my_product_json.json');
  //   final list = json.decode(rawData) as List<dynamic>;
  //   return list.map((model) => Product2.fromJson(model)).toList();
  // }

  List<Product> listProduct = [];
  Future<List<Product>> _fetchdata() async {
    final res = await ApiService().getData('product');
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      print(json);
      ProductModel respProduct = ProductModel.fromJson(json);
      respProduct.product.forEach((item) {
        listProduct.add(item);
      });
      return listProduct;
    } else {
      print(res);
      print('something wrong');
      return [];
    }
  }
}