import 'package:flutter/material.dart';
import 'package:new_moedah_app/models/mcategory.dart';

Widget itemCategory(Category category) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.network(
            category.id.toString(),
            height: 100.0,
            width: double.infinity,
            fit: BoxFit.cover,
            // width: double.infinity,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  category.name,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  category.description,
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
