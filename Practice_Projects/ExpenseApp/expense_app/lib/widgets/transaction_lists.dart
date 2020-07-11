import 'package:expense_app/models/transaction.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTrans;

  TransactionList(this.transactions, this.removeTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxHeight * 1,
                  width: constraints.maxWidth * 1,
                  child: Image.asset(
                    "assets/images/pic.png",
                    fit: BoxFit.cover,
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 85.0,
                  child: Card(
                    child: Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 35.0,
                          child: FittedBox(
                            child: Text(
                              "\$ ${transactions[index].amount.toStringAsFixed(2)}", // tx.amount.toString() can be replaced by ${tx.amount}
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              transactions[index].title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              DateFormat('MMMM-dd-yyyy')
                                  .format(transactions[index].date),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      MediaQuery.of(context).orientation == Orientation.landscape ? SizedBox(width: 500) : SizedBox(width: 150) ,
                      MediaQuery.of(context).size.width > 500
                          ? FlatButton.icon(
                              onPressed: () =>
                                  removeTrans(transactions[index].id),
                              icon: Icon(Icons.delete, color: Colors.red),
                              label: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () =>
                                  removeTrans(transactions[index].id))
                    ]),
                  ),
                );
              }),
    );
  }
}
