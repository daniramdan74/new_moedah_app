import 'package:floor/floor.dart';
import 'package:new_moedah_app/entity/cart.dart';

@dao
abstract class CartDao{
@Query('SELECT * FROM Cart WHERE uid=:uid')
Stream<List<Cart>> getAllItemInCartByUid(String uid);

@Query('SELECT * FROM Cart WHERE uid=:uid AND id=:id')
Future<Cart> getItemInCartByUid(String uid, int id);

@Query('DELETE * FROM Cart WHERE uid=:uid')
Stream<List<Cart>> clearCartByUid(String uid);

@Query('DELETE FROM Cart')
Future<Cart> deleteAllCart();

@insert
Future<void> insertCart(Cart product);

@update
Future<int> updatetCart(Cart product);
@delete
Future<int> deleteCart(Cart product);
}