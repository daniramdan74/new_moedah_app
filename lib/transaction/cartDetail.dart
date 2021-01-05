import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_moedah_app/const/const.dart';
import 'package:new_moedah_app/dao/cartDao.dart';
import 'package:new_moedah_app/entity/cart.dart';
import 'package:new_moedah_app/transaction/transactionDetailPage.dart';

class CartDetail extends StatefulWidget {
  final CartDao cartDao;
  CartDetail({Key key, this.cartDao}) : super(key: key);
  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Detail'),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder(
          stream: widget.cartDao.getAllItemInCartByUid(uID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data as List<Cart>;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: items == null ? 0 : items.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            child: Card(
                                elevation: 8,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6.0),
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            child: ClipRRect(
                                          // child: Image(
                                          child: Image.asset(
                                              'assets/images/product.png'),
                                          // image: NetworkImage(
                                          //     items[index].imgurl),
                                          //  fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        )),
                                        Expanded(
                                            flex: 6,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8, right: 8),
                                                    child: Text(
                                                      items[index].name,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                        top: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: <Widget>[
                                                        Text('Rp'),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Text(
                                                            items[index].price,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Center(
                                          child: ElegantNumberButton(
                                            initialValue: items[index].qty,
                                            buttonSizeWidth: 25,
                                            buttonSizeHeight: 20,
                                            color: Colors.white38,
                                            minValue: 0,
                                            maxValue: 100,
                                            decimalPlaces: 0,
                                            onChanged: (value) async {
                                              items[index].qty = value;
                                              await widget.cartDao
                                                  .updatetCart(items[index]);
                                            },
                                          ),
                                        )
                                      ],
                                    ))),
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Delete',
                                icon: Icons.delete,
                                color: Colors.red,
                                onTap: () async {
                                  await widget.cartDao.deleteCart(items[index]);
                                },
                              )
                            ],
                          );
                        }),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\Rp ${items.length > 0 ? items.map<double>((m) => double.parse(m.price) * m.qty).reduce((value, element) => value + element) : 0}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Delivery Charge',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\Rp ${items.length > 0 ? items.map<double>((m) => double.parse(m.price) * m.qty).reduce((value, element) => value + element) * 0.1 : 0}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Sub Total',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\Rp ${items.length > 0 ? (items.map<double>((m) => double.parse(m.price) * m.qty).reduce((value, element) => value + element)) + items.map<double>((m) => double.parse(m.price) * m.qty).reduce((value, element) => value + element) * 0.1 : 0}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                              color: Colors.blueAccent,
                              padding: EdgeInsets.symmetric(horizontal: 150),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text('Pay',
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.white)),
                              onPressed: (){
                                String subTotal =
                                    '${items.length > 0 ? (items.map<double>((m) => double.parse(m.price) * m.qty).reduce((value, element) => value + element)) + items.map<double>((m) => double.parse(m.price) * m.qty).reduce((value, element) => value + element) * 0.1 : 0}';
                                String total =
                                    '${items.length > 0 ? items.map<double>((m) => double.parse(m.price) * m.qty).reduce((value, element) => value + element) : 0}';
                                              // Navigator.pushNamed(context, "/transactionPay");
                                              // Navigator.pushReplacementNamed(BuildContext context, "/transactionPay",{});
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionDetailPage(
                                              subTotal: subTotal, total: total,cartDao: widget.cartDao,),
                                    ));
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text('cart Detail Error'),
              );
            }
          }),
    );
  }
}
