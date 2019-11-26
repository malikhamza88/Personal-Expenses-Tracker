import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, contraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: contraints.maxHeight * 0.05,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 7.0),
                    height: contraints.maxHeight * 0.8,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: _userTransactions.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                key: ValueKey(_userTransactions[index].id),
                transaction: _userTransactions[index],
                deleteTx: _deleteTx,
              );
            },
          );
  }
}
