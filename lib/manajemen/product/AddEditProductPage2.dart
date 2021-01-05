import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/models/mcategory.dart';
import 'package:new_moedah_app/models/mproduct.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';

class AddEditProductPage2 extends StatefulWidget {
  final Product product;
  AddEditProductPage2({this.product});
  @override
  _AddEditProductPage2State createState() => _AddEditProductPage2State();
}

class _AddEditProductPage2State extends State<AddEditProductPage2> {
  final _formKey = GlobalKey<FormState>();

  //category
  String _valCategory;
  // List<Category> listCategory = List();
  // Future<List<Category>> _getCategory() async {
  //   final res = await ApiService().getData('categories');
  //   if (res.statusCode == 200) {
  //     final json = jsonDecode(res.body);
  //     CategoryModel respCategory = CategoryModel.fromJson(json);
  //     respCategory.categories.forEach((item) {
  //       listCategory.add(item);
  //     });
  //     return listCategory;
  //   } else {
  //     print(res);
  //     print('something wrong');
  //     return [];
  //   }
  // }
  List<dynamic> listCategory = List();
  void _getCategory() async {
    final res = await ApiService().getData('categories');
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      CategoryModel respCategory = CategoryModel.fromJson(json);
      respCategory.categories.forEach((item) {
        listCategory.add(item);
      });
      // return listCategory;
    } else {
      print(res);
      print('something wrong');
      return;
    }
  }

  bool _validate = false;
  bool _isUpdate = false;

  String _idProduct;
  TextEditingController _nmProduct, _dcProduct, _stock, _price;

  ApiService service = ApiService();
  bool _success;
  ProductModel responsePostProduct;

  void checkValidasi() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_isUpdate) {
        _handleUpdateProduct(_idProduct);
      } else {
        _handleCreateProduct();
      }

      _success = responsePostProduct.success;

      if (_success) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.product, (route) => false);
        setState(() {});
        SnackBar(content: Text('berhasil'));
      } else {
        SnackBar(content: Text('gagal'));
      }
    } else {
      _validate = true;
    }
  }

  String validator(String value) {
    if (value.isEmpty)
      return "jangan kosong";
    else
      return null;
  }

  @override
  void initState() {
    super.initState();
    _getCategory();

    if (widget.product != null) {
      _isUpdate = true;
      _idProduct = widget.product.id.toString();

      _nmProduct = TextEditingController(text: widget.product.name);
      _dcProduct = TextEditingController(text: widget.product.description);
      _stock = TextEditingController(text: widget.product.stock);
      _price = TextEditingController(text: widget.product.price);
      // setState(() {
      //     _valCategory =  widget.product.categoryId.toString();
      // });
      // _categoryId =
      // TextEditingController(text: widget.product.categoryId.toString());
      _valCategory = widget.product.categoryId.toString();
    } else {
      _nmProduct = TextEditingController();
      _dcProduct = TextEditingController();
      _stock = TextEditingController();
      _price = TextEditingController();
      _valCategory.toString();
    }
  }

  void _handleCreateProduct() async {
    var data = {
      'name': _nmProduct.text,
      'description': _dcProduct.text,
      'stock': _stock.text,
      'price': _price.text,
      'category_id': _valCategory.toString(),
    };
    print(data);
    var res = await ApiService().postData(data, 'product');
    var body = json.decode(res.body);
    print(res);
    print(body);
    if (res.statusCode == 201) {
      Navigator.pushReplacementNamed(context, Routes.product);
      return print('data berhasil dibuat');
    } else {
      return print('gagal');
    }
  }

  void _handleUpdateProduct(id) async {
    var data = {
      'name': _nmProduct.text,
      'description': _dcProduct.text,
      'stock': _stock.text,
      'price': _price.text,
      'category_id': _valCategory.toString(),
    };
    // print(data);
    var res = await ApiService().updateData(id, data, 'product');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 200) {
      Navigator.pushReplacementNamed(context, Routes.product);
      return print('data berhasil diubah');
    } else {
      return print('gagal diubah');
    }
  }

  void _handledeleteProduct(id) async {
    var res = await ApiService().deleteData(id, 'product');
    var body = json.decode(res.body);
    print(res);
    print(body);
    if (res.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.product, (route) => false);
      return print('data berhasil dihapus');
    } else {
      return print('data gagal dihapus');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isUpdate ? Text('Update Data') : Text('Tambah Data'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.product);
            }),
        actions: <Widget>[
          _isUpdate
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    _handledeleteProduct(_idProduct);
                  },
                )
              : Text('')
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              autovalidate: _validate,
              key: _formKey,
              child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(children: <Widget>[
                    Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/product.png'),
                                fit: BoxFit.fill,
                              ),
                              // image: DecorationImage(
                              // fit: BoxFit.cover,
                              // Image.asset('assets/images/product.png'),
                              // image: NetworkImage(
                              //     'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200')
                              //     )
                            ),
                          ),
                          // Positioned(
                          //     bottom: 0,
                          //     right: 0,
                          //     child: Container(
                          //         height: 40,
                          //         width: 40,
                          //         decoration: BoxDecoration(
                          //             shape: BoxShape.rectangle,
                          //             border: Border.all(
                          //               width: 3,
                          //               color: Theme.of(context)
                          //                   .scaffoldBackgroundColor,
                          //             ),
                          //             color: Colors.blueAccent),
                          //         child:
                          //             Icon(Icons.edit, color: Colors.white))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: _nmProduct,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _dcProduct,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _stock,
                      decoration: InputDecoration(
                        labelText: 'Stock',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _price,
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
                      hint: Text("Select The Category"),
                      value: _valCategory,
                      items: listCategory.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.name),
                          value: item.id.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valCategory =
                              value; //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                        });
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Text('Save',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white)),
                      onPressed: checkValidasi,
                    ),
                  ]))),
        ),
      ),
    );
  }
}
