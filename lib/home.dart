import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loginflutter/transaction.dart';
import 'package:loginflutter/transactionclass.dart';

class Home extends StatefulWidget {
  final List<Transaction> transactions;
   // Add the transactions parameter

  const Home({Key? key, required this.transactions}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  bool isReloading = false;


  void addTransaction(Transaction transaction) {
    setState(() {
      transactions.insert(0,
          transaction); // Insert the transaction at the beginning of the list
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isReloading = true; // Set the reloading flag to true
    });

    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 1));

    // Perform the reload logic here
    // For example, you can fetch new recent transactions

    setState(() {
      isReloading = false; // Set the reloading flag back to false
    });
  }

    


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/potential.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            title: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.yellow,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'This month',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Perform your search action here
                          // Add your logic to execute when the search icon is pressed
                          Navigator.pushNamed(context, 'transaction');
                          
                        },
                        child: Icon(Icons.search, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'PLATINUM CARD',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(154, 0, 0, 0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: -3,
                                    right: 4,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:
                                              AssetImage('lib/assets/chip.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    bottom: 50,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 80,
                                    bottom: 70,
                                    child: Text(
                                      'Spending',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    bottom: 50,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 230,
                                    bottom: 70,
                                    child: Text(
                                      'Income',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                 
                                  Positioned(
                                    left: 20,
                                    bottom: 15,
                                    child: Text(
                                      'CARD HOLDER NAME',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'transaction');
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Display the list of transactions
                    Container(
                      
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            transactions.length > 10 ? 10 : transactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final transaction = transactions[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 230, 64, 52),
                              border: Border.all(
                                  color:
                                      Colors.white), // Set the border properties
                              borderRadius: BorderRadius.circular(
                                  10), // Set the border radius
                            ),
                            margin:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: ListTile(
                              title: Text(
                                '\Rs${transaction.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                transaction.notes,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Text(
                                transaction.date,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
                  fontStyle: FontStyle.italic,
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
      ),
    );
  }
}
