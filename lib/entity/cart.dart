import 'package:floor/floor.dart';

@entity
class Cart {
  @primaryKey
  final int id;

  final String uid, name, description, category, price;
  int qty;
  Cart(
      {this.id,
      this.uid,
      this.name,
      this.description,
      this.category,
      this.price,
      // this.imgurl,
      this.qty});
}
