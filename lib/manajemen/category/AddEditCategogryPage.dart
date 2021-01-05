import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_moedah_app/models/mcategory.dart';
import 'package:new_moedah_app/routes/routes.dart';
import 'package:new_moedah_app/service/apiService.dart';

class AddEditCategogryPage extends StatefulWidget {
  // static const String routeName = '/addeditcategory';
  final Category category;
  AddEditCategogryPage({this.category});
  @override
  _AddEditCategogryPageState createState() => _AddEditCategogryPageState();
}

class _AddEditCategogryPageState extends State<AddEditCategogryPage> {
  final _formKey = GlobalKey<FormState>();

  bool _validate = false;
  bool _isUpdate = false;

  String _idCategory;
  TextEditingController _nmCategory, _dcCategory;

  ApiService service = ApiService();
  bool _success;
  CategoryModel responsePostCategory;

  void checkValidasi() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_isUpdate) {
        _handleUpdateCategory(_idCategory);
        // responsePostCategory = await service.upddateCategory(
        //     _apiurl, _idCategory, _nmCategory.text, _dcCategory.text);
      } else {
        _handleCreateCategory();
      }

      _success = responsePostCategory.success;

      if (_success) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.category, (route) => false);
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
      return "Tidak Boleh Kosong";
    else
      return null;
  }

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      _isUpdate = true;
      _idCategory = widget.category.id.toString();

      _nmCategory = TextEditingController(text: widget.category.name);
      _dcCategory = TextEditingController(text: widget.category.description);
    } else {
      _nmCategory = TextEditingController();
      _dcCategory = TextEditingController();
    }
  }

  void _handleCreateCategory() async {
    var data = {
      'name': _nmCategory.text,
      'description': _dcCategory.text,
    };
    // print(data);
    var res = await ApiService().postData(data, 'categories');
    var body = json.decode(res.body);
    print(res);
    print(body);
    if (res.statusCode == 201) {
      Navigator.pushReplacementNamed(context, Routes.category);
      return print('data berhasil dibuat');
    } else {
      return print('gagal');
    }
  }

  void _handleUpdateCategory(id) async {
    var data = {
      'name': _nmCategory.text,
      'description': _dcCategory.text,
    };
    // print(data);
    var res = await ApiService().updateData(id, data, 'categories');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 200) {
      Navigator.pushReplacementNamed(context, Routes.category);
      return print('data berhasil diubah');
    } else {
      return print('gagal diubah');
    }
  }

  void _handledeleteCategory(id) async {
    var res = await ApiService().deleteData(id, 'categories');
    var body = json.decode(res.body);
    print(res);
    print(body);
    if (res.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.category, (route) => false);
      return print('data berhasil dihapus');
    } else {
      return print('data gagal dihapus');
    }

    //   return print('data berhasil dihapus');
    // } else {
    //   return print('gagal dihapus');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isUpdate ? Text('Update Data') : Text('Tambah Data'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.category);
            }),
        actions: <Widget>[
          _isUpdate
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    _handledeleteCategory(_idCategory);
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
                    controller: _nmCategory,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama Category'),
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    controller: _dcCategory,
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
