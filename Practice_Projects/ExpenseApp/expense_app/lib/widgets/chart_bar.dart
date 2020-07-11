import "package:flutter/material.dart";

class ChartBar extends StatelessWidget {
  final String dayLabel;

  final double spending;

  final double percTotalSpending;

  ChartBar(this.dayLabel, this.spending, this.percTotalSpending);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                              child: Text(
                  dayLabel,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.60,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percTotalSpending,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "\$${spending.toStringAsFixed(0)}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
