import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/models/mproduct.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';

class AddEditProductPage extends StatefulWidget {
  final Product product;
  AddEditProductPage({this.product});
  @override
  _AddEditProductPageState createState() => _AddEditProductPageState();
}
 
class _AddEditProductPageState extends State<AddEditProductPage> {

  final _formKey = GlobalKey<FormState>();

  bool _validate = false;
  bool _isUpdate = false;

  String _idProduct;
  TextEditingController _nmProduct, _dcProduct;

  ApiService service = ApiService();
  bool _success;
  ProductModel responsePostProduct;

  void checkValidasi() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_isUpdate) {
         _handleUpdateProduct(_idProduct);
        // responsePostCategory = await service.upddateCategory(
        //     _apiurl, _idCategory, _nmCategory.text, _dcCategory.text);
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

    if (widget.product != null) {
      _isUpdate = true;
      _idProduct = widget.product.id.toString();

      _nmProduct = TextEditingController(text: widget.product.name);
      _dcProduct = TextEditingController(text: widget.product.description);
    } else {
      _nmProduct = TextEditingController();
      _dcProduct = TextEditingController();
    }
  }

  void _handleCreateProduct() async {
    var data = {
      'name': _nmProduct.text,
      'description': _dcProduct.text,
      'stock':'20',
      'price':'4000',
      'category_id':'29'
    };
    // print(data);
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
      'stock':'20',
      'price':'4000',
      'category_id':'29'
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
                    // await service
                    //     .delCategory('categories', _idCategory.toString())
                    //     .then((value) {
                    //   if (value.success) {
                    //     Navigator.pushNamedAndRemoveUntil(
                    //         context, Routes.category, (route) => false);
                    //     SnackBar(content: Text('berhasil Menghapus'));
                    //   } else {
                    //     SnackBar(content: Text('berhasil Menghapus'));
                    //   }
                    // });
                  },
                )
              : Text('')
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            autovalidate: _validate,
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _nmProduct,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama Product'),
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _dcProduct,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Description'),
                    validator: validator,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'SIMPAN',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: checkValidasi,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
