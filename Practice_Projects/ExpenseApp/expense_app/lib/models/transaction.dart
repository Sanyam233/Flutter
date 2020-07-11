//creating a transaction app 

//importing the library for required keyword
import "package:flutter/foundation.dart";

class Transaction{

  final String id;
  final String title;
  final double amount;
  final DateTime date;

  //constructor 
  Transaction({@required this.id, @required this.title, @required this.amount, @required this.date});
}