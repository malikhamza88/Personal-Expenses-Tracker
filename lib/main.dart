import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transactions.dart';
import 'package:personal_expenses/widgets/transation_list.dart';

import 'models/transaction.dart';

void main() {
  /*
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  */
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans'),
      title: 'Personal Expenses',
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Computer',
      amount: 50.78,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Computer',
      amount: 50.78,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Computer',
      amount: 122350.78,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((item) => item.id == id);
    });
  }

  List<Widget> buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appbar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show Chart'),
          Switch.adaptive(
            value: _showChart,
            onChanged: (newValue) {
              setState(() {
                _showChart = newValue;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: Chart(
                recentTransaction: recentTransactions,
              ),
            )
          : txListWidget
    ];
  }

  List<Widget> buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appbar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(
          recentTransaction: recentTransactions,
        ),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appbar = AppBar(
      title: Text(
        'Personal Expenses Tracker',
        style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
        softWrap: true,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => buildBottomSheet(context),
          tooltip: 'Add new Transection',
        )
      ],
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (isLandscape)
                  ...buildLandscapeContent(
                    mediaQuery,
                    appbar,
                    txListWidget,
                  ),
                if (!isLandscape)
                  ...buildPortraitContent(
                    mediaQuery,
                    appbar,
                    txListWidget,
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: Platform.isIOS
            ? Container()
            : FloatingActionButton(
                onPressed: () => buildBottomSheet(context),
                child: Icon(
                  Icons.add,
                ),
                tooltip: 'Add new transaction',
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: appbar);
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: dateTime,
    );
    setState(
      () {
        _userTransactions.add(newTx);
      },
    );
  }

  void buildBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (bctx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            addTx: _addNewTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}
