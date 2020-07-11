import "dart:io";

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function triggerTransaction;

  NewTransaction(this.triggerTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  var userDate;

  submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || userDate == null) {
      return;
    }

    widget.triggerTransaction(enteredTitle, enteredAmount, userDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((pickeddate) {
      if (pickeddate == null) {
        return;
      }

      setState(() {
        userDate = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: "Title",
                        controller: titleController,
                        onSubmitted: (_) => submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(labelText: "Title"),
                        controller: titleController,
                        onSubmitted: (_) => submitData(),
                      ),
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: "Amount",
                        controller: amountController,
                        onSubmitted: (_) => submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(labelText: "Amount"),
                        controller: amountController,
                        onSubmitted: (_) => submitData(),
                      ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        userDate == null
                            ? "No date Choosen"
                            : "Picked Date:   ${DateFormat("MMMM-dd-yyyy").format(userDate)}",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: FlatButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Pick a Date",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: _presentDatePicker,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0))),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Platform.isIOS
                    ? CupertinoButton(
                        minSize: 0.25,
                        child: Text(
                          "Add Transaction",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: submitData,
                      )
                    : FlatButton(
                        onPressed: submitData,
                        child: Text(
                          "Add Transaction",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
