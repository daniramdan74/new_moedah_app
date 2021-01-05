
import 'package:flutter/material.dart';
import 'package:new_moedah_app/const/const.dart';
import 'package:new_moedah_app/dao/cartDao.dart';
import 'package:new_moedah_app/entity/cart.dart';
import 'package:new_moedah_app/models/mproduct.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key key, this.product, this.cartDao}) : super(key: key);
  final Product product;
  final CartDao cartDao;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Column(children: <Widget>[
        Image.asset('assets/images/product.png'),
        // Image.network(
        //   product.imageUrl,
        //   fit: BoxFit.fill,
        // ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(children: [
            Text(
              '${product.name}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text.rich(TextSpan(children: [
                  TextSpan(text: '\Rp ${product.price}')
                ])),
                GestureDetector(onTap: ()async{
                  var cartProduct = await cartDao.getItemInCartByUid(uID, product.id);
                  if(cartProduct!=null){
                    cartProduct.qty+=1;// increase qty if alreadey incart
                    await cartDao.updatetCart(cartProduct);

                  }else{
                    Cart cart = new Cart(id: product.id,
                    price: product.price,
                    category: product.categoryId.toString(),
                    qty: 1,
                    name: product.name,
                    uid: uID,
                    );
                    await cartDao.insertCart(cart);
                  }
                },
                child: Icon(Icons.shopping_basket),)
              ],
            )
          ]),
        )
      ]),
    );
  }
}
