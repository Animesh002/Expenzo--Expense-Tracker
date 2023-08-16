import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:loginflutter/calculator_keyboard.dart';
import 'package:loginflutter/transaction.dart';
import 'package:loginflutter/transactionclass.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class Expense {
  final String date;
  final double amount;
  final String notes;

  Expense({
    required this.date,
    required this.amount,
    required this.notes,
  });
}

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 1;

  @override
  Expense read(BinaryReader reader) {
    final date = reader.readString();
    final amount = reader.readDouble();
    final notes = reader.readString();

    return Expense(
      date: date,
      amount: amount,
      notes: notes,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer.writeString(obj.date);
    writer.writeDouble(obj.amount);
    writer.writeString(obj.notes);
  }
}

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  bool isExpenseSelected = true;
  bool isCalculatorOpen = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  late Box<Expense> _expenseBox; // Expense box
  bool boxOpen = false;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(ExpenseAdapter());
    _expenseBox = await Hive.openBox<Expense>('expenses');
    setState(() {
      boxOpen = true;
    });
  }

  @override
  void dispose() {
    Hive.close(); // Close the Hive box
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showCalculatorKeyboard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: CalculatorKeyboard(amountController: amountController),
        );
      },
    );
  }

  void _saveExpense() {
    final amountText = amountController.text.trim();
    final notes = notesController.text.trim();

    if (amountText.isNotEmpty && double.tryParse(amountText) != null) {
      final amount = double.parse(amountText);
      final transaction = Transaction(
        date: DateFormat('MMM dd, yyyy').format(selectedDate),
        amount: amount,
        notes: notes,
        id: '',
      );
      transactions.add(transaction);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Expense saved successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // Clear the form fields
      amountController.clear();
      notesController.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a valid amount.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (isCalculatorOpen) {
        _showCalculatorKeyboard(context);
      }
    });

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
          title: Text(
            'Add Expense',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.yellow,
            ),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isExpenseSelected = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            isExpenseSelected ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'Expenses',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          color:
                              isExpenseSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 27),
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: EdgeInsets.only(bottom: 16),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        DateFormat('MMM dd, yyyy').format(selectedDate),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: EdgeInsets.only(bottom: 16),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '\u20B9', // Indian rupee symbol
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color:
                                  Colors.white), // Set the text color to white
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isCalculatorOpen = !isCalculatorOpen;
                        });
                      },
                      icon: Icon(Icons.calculate),
                      label: Text(
                        'Calculator',
                        style: TextStyle(
                          color: isCalculatorOpen ? Colors.blue : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0.0,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: EdgeInsets.only(bottom: 16),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.notes, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: notesController,
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter notes',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Colors.black, // Set the border color to black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveExpense,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 25,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, size: 24, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Rest of your code...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
