import 'package:flutter/material.dart';
import 'package:loginflutter/transactionclass.dart';
import 'package:uuid/uuid.dart';


List<Transaction> transactions = [];

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String selectedOption = 'Date created'; // Default selected option
  String searchQuery = ''; // Variable to hold the search query



  void _showTransactionOptionsModal(BuildContext context, Transaction transaction) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Transaction Options',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  deleteTransaction(transaction); // Call the deleteTransaction method
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('Duplicate'),
                onTap: () {
                  duplicateTransaction(transaction); // Call the duplicateTransaction method
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteTransaction(Transaction transaction) {
    setState(() {
      transactions.remove(transaction);
    });
  }

  void duplicateTransaction(Transaction transaction) {
    setState(() {
      final duplicatedTransaction = Transaction(
        id: Uuid().v4(),
        date: transaction.date,
        amount: transaction.amount,
        notes: transaction.notes,
      );
      transactions.add(duplicatedTransaction);
    });
  }

  List<Transaction> getFilteredTransactions() {
    if (searchQuery.isEmpty) {
      return transactions; // Return all transactions if search query is empty
    } else {
      return transactions
          .where((transaction) =>
              transaction.amount.toString().contains(searchQuery.toLowerCase()) ||
              transaction.date.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }



  @override
  Widget build(BuildContext context) {
    final filteredTransactions = getFilteredTransactions();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/potential.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'All Transaction',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTransactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final transaction = filteredTransactions[index];
                    return GestureDetector(
                      onLongPress: () {
                        _showTransactionOptionsModal(context, transaction);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 230, 64, 52),
                          border: Border.all(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: ListTile(
                          title: Text(
                            '\Rs${transaction.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            transaction.notes,
                            style: TextStyle(
                         fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Text(
                            transaction.date,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
            child: Text(
              '+ Add Expense',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              primary: Color(0xffffff00),
              onPrimary: Color(0xff6953F7),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'expense');
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

