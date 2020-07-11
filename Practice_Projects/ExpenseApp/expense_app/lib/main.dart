import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_lists.dart';
import './models/transaction.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'RobotoSlab',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: "RobotoSlab", fontSize: 22.0),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final List<Transaction> _transactions = [];

  void _addNewTransaction(String txtitle, double txamount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: date);

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startTrasaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  Widget _cupertinoBuilder(){

    return CupertinoNavigationBar(
            trailing: GestureDetector(
              onTap: () => _startTrasaction(context),
              child: Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            middle: Text(
              "Expense Tracker",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );

  }

  Widget _appBarBuilder(){

    return AppBar(
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    onPressed: () => _startTrasaction(context)),
              )
            ],
            title: Text(
              "Expense Tracker",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );

  }

  

  @override
  Widget build(BuildContext context) {

    final deviceInfo = MediaQuery.of(context);

    final PreferredSizeWidget appBar = Platform.isIOS
        ? _cupertinoBuilder()
        : _appBarBuilder();

    var body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: deviceInfo.orientation == Orientation.portrait
                  ? (deviceInfo.size.height -
                          appBar.preferredSize.height -
                          deviceInfo.padding.top) *
                      0.25
                  : (deviceInfo.size.height -
                          appBar.preferredSize.height -
                          deviceInfo.padding.top) *
                      0.50,

              child: Chart(_recentTransactions),
            ),
            Container(
              height: deviceInfo.orientation == Orientation.portrait
                  ? (deviceInfo.size.height -
                          appBar.preferredSize.height -
                          deviceInfo.padding.top) *
                      0.75
                  : (deviceInfo.size.height -
                          appBar.preferredSize.height -
                          deviceInfo.padding.top) *
                      0.50,
              child: TransactionList(_transactions, removeTransaction),
            ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startTrasaction(context),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 26.0,
                    ),
                    backgroundColor: Colors.red,
                  ),
          );
  }
}
