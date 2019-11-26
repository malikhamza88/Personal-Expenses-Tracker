import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction({this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _choosedDate;

  void _submitData() {
    if (_amountInput.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleInput.text;
    final enteredAmount = double.parse(_amountInput.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _choosedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _choosedDate,
    );
    Navigator.pop(context);
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _choosedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleInput,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: _amountInput,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _choosedDate == null
                            ? 'No Date chosen!'
                            : 'Picked Date: ${DateFormat.yMMMd().format(_choosedDate)}',
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    FlatButton(
                      onPressed: () {
                        _showDatePicker();
                      },
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                elevation: 7,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
