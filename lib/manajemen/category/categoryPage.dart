import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/manajemen/category/AddEditCategogryPage.dart';
import 'package:new_moedah_app/models/mcategory.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = '/category';
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category> listCategory = [];

  Future<List<Category>> _fetchdata() async {
    final res = await ApiService().getData('categories');
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      CategoryModel respCategory = CategoryModel.fromJson(json);
      respCategory.categories.forEach((item) {
        listCategory.add(item);
      });
      return listCategory;
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
          title: Text('Category'),
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
                  child: FutureBuilder<List<Category>>(
                      future: _fetchdata(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          List<Category> listCategory = snapshot.data;
                          return ListView.builder(
                              itemCount: listCategory?.length ?? 0,
                              // itemCount: listCategory.length,
                              itemBuilder: (context, i) {
                                final x = listCategory[i];
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.category,
                                          color: Theme.of(context).primaryColor,
                                          size: 30.0,
                                        ),
                                        title: Text(x.name),
                                        subtitle: Text(x.description),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEditCategogryPage(
                                                          category:
                                                              listCategory[
                                                                  i])));
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
                        // Navigator.pushReplacementNamed(context, Routes.addEditCategory);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEditCategogryPage(
                                      category: null,
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
