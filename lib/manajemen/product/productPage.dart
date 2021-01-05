import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/manajemen/product/AddEditProductPage2.dart';
import 'package:new_moedah_app/models/mproduct.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';

class ProductPage extends StatefulWidget {
  static const String routeName = '/product';
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Product'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.manajemen);
              }),
        ),
        body: Stack(children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: FutureBuilder<List<Product>>(
                      future: _fetchdata(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          List<Product> listProduct = snapshot.data;
                          return ListView.builder(
                              itemCount: listProduct?.length ?? 0,
                              // itemCount: listCategory.length,
                              itemBuilder: (context, i) {
                                final x = listProduct[i];
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Image.asset(
                                          'assets/images/product2.png',
                                        ),
                                        // leading: Icon(
                                        //   Icons.fastfood,
                                        //   color: Theme.of(context).primaryColor,
                                        //   size: 30.0,
                                        // ),
                                        title: Text(x.name),
                                        subtitle: Text(x.price),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      // AddEditProductPage(
                                                      AddEditProductPage2(
                                                          product:
                                                              listProduct[i])));
                                        },
                                      ),
                                      Divider(thickness: 1, height: 10),
                                    ],
                                  ),
                                );
                              });
                        }
                      })),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // builder: (context) => AddEditProductPage(
                                builder: (context) => AddEditProductPage2(
                                      product: null,
                                    )));
                      }),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          )
        ]));
  }
}
