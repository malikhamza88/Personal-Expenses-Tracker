import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTx;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        subtitle: Text(
          DateFormat.yMMMEd().format(widget.transaction.date),
        ),
        title: Text(
          widget.transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              '${widget.transaction.amount.toStringAsFixed(2)} R.s',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: const Icon(
                  Icons.delete,
                ),
                textColor: Theme.of(context).errorColor,
                label: const Text(
                  'Delete',
                ),
              )
            : IconButton(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
      ),
    );
  }
}
