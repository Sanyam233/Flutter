import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> currentTransaction;

  const Chart(this.currentTransaction);

  List get groupedTransaction {

    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for (int i = 0; i < currentTransaction.length; i++) {
        var ct = currentTransaction[i];

        if (ct.date.day == weekDay.day &&
            ct.date.month == weekDay.month &&
            ct.date.year == weekDay.year) {
          totalSum += ct.amount;
        }
      }

      print(DateFormat.E().format(weekDay) + " " + totalSum.toString());

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransaction.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6.0,
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((data) {
            return Flexible(fit: FlexFit.tight,
              child: ChartBar(
                data["day"],
                data["amount"],
                totalSpending == 0.0 ? 0.0 : ((data["amount"] as double) / totalSpending),
              ),
            );
          }).toList(),
        ),
      );
  }
}
