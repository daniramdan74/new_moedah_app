import 'package:flutter/material.dart';
import 'package:new_moedah_app/dao/cartDao.dart';
import 'package:new_moedah_app/routes/routes.dart';

class TransactionDetailPage extends StatefulWidget {
  final String subTotal;
  final String total;
  final CartDao cartDao;

  TransactionDetailPage({Key key, this.subTotal, this.total, this.cartDao})
      : super(key: key);
  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  void initState() {
    super.initState();
    widget.cartDao.deleteAllCart();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text('\Rp ${widget.subTotal}'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Center(
            child: Container(
                padding: EdgeInsets.all(20),
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/ceklist.png'),
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Total :",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '\Rp ${widget.subTotal}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                    padding: EdgeInsets.all(12),
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'New Transaction',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.transaction);
                    }),
                SizedBox(
                  height: 10,
                ),
                OutlineButton(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.print,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Print',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.settings,
                          color: Colors.blueAccent,
                        )
                      ],
                    ),
                    onPressed: () {}),
                SizedBox(
                  height: 10,
                ),
                OutlineButton(
                    padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.receipt,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'See Receipt',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
