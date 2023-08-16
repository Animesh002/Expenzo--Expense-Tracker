import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_advanced/sms_advanced.dart';

class psettings extends StatefulWidget {
  const psettings({Key? key}) : super(key: key);

  @override
  State<psettings> createState() => _psettingsState();
}

class _psettingsState extends State<psettings> {
  bool isFirstTime = true; // Flag to track if it's the first time visiting the passbook page
  bool isGreenBoxVisible = true; // Flag to track the visibility of the green box
  int selectedDay = 1; // Selected day value
  String selectedEntryType = ''; // Selected entry type value

  @override
  void initState() {
    super.initState();
    checkPermission();
    showOverlay(context);
  }

  void checkPermission() async {
    // Check if SMS permission is granted
    PermissionStatus status = await Permission.sms.status;

    if (status.isDenied && isFirstTime) {
      // Request SMS permission
      status = await Permission.sms.request();

      if (status.isGranted) {
        Fluttertoast.showToast(msg: 'SMS permission granted');
      } else {
        Fluttertoast.showToast(msg: 'SMS permission denied');
      }

      setState(() {
        isFirstTime = false; // Update the flag after permission is granted or denied
      });
    }
  }

  void openDateModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                height: 580,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Select Date Filter',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile<int>(
                            title: Text('All Time'),
                            value: 1,
                            groupValue: selectedDay,
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value!;
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text('Today'),
                            value: 2,
                            groupValue: selectedDay,
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value!;
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text('Yesterday'),
                            value: 3,
                            groupValue: selectedDay,
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value!;
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text('This Month'),
                            value: 4,
                            groupValue: selectedDay,
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value!;
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text('Last Month'),
                            value: 5,
                            groupValue: selectedDay,
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value!;
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text('Single Day'),
                            value: 6,
                            groupValue: selectedDay,
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value!;
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: Text('Date Range'),
                            value: 7,
                            groupValue: selectedDay,
                            onChanged: (value) {
                              setState(() {
                                selectedDay = value!;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Implement first button functionality
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('CLEAR ALL'),
                                ),
                              ),
                              SizedBox(width: 1),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Implement second button functionality
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('APPLY'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openEntryTypeModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            String selectedEntryType = '';

            return SingleChildScrollView(
              child: Container(
                height: 400,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Select Entry Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile<String>(
                            title: Text('All'),
                            value: 'All',
                            groupValue: selectedEntryType,
                            onChanged: (value) {
                              setState(() {
                                selectedEntryType = value!;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text('Cash In'),
                            value: 'Cash In',
                            groupValue: selectedEntryType,
                            onChanged: (value) {
                              setState(() {
                                selectedEntryType = value!;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text('Cash Out'),
                            value: 'Cash Out',
                            groupValue: selectedEntryType,
                            onChanged: (value) {
                              setState(() {
                                selectedEntryType = value!;
                              });
                            },
                          ),
                          // Add more RadioListTile widgets for additional entry types

                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedEntryType = ''; // Clear selected entry type
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('CLEAR ALL'),
                                ),
                              ),
                              SizedBox(width: 1),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Apply button functionality
                                    Navigator.pop(context); // Close the modal box
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('APPLY'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showOverlay(BuildContext context) async {
  final OverlayState? overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;
  SmsQuery query = new SmsQuery();
  
  List<SmsMessage> messages = [];

  try {
   messages = await query.getAllSms;
   print(messages);
  } catch (e) {
    print('Error fetching inbox messages: $e');
  }

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: () {
            overlayEntry.remove();
          },
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0), // Adjust the padding values to move the cross button
                    child: GestureDetector(
                      onTap: () {
                        overlayEntry.remove();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Perform "Add to Passbook" functionality
                        //overlayEntry.remove();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Add to Passbook'),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final SmsMessage message = messages[index];
                    return ListTile(
                      title: Text(message.address ?? ''),
                      subtitle: Text(message.body ?? ''),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  overlayState?.insert(overlayEntry);
}





  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 20,),
              Text(
                'More',
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
        body: Column(
          children: [
            if (isGreenBoxVisible) // Render the green box only if it should be visible
              Container(
                color: Color.fromARGB(255, 87, 170, 90),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.lock, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Only you can see passbook entries',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              openDateModal(); // Open date modal box
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            icon: Icon(Icons.calendar_today),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date Filter'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              openEntryTypeModal(); // Open entry type modal box
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            icon: Icon(Icons.filter_alt),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Entry Type'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10, // Replace with actual item count
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Passbook Entry $index'),
                          subtitle: Text('Details of entry $index'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
          onPressed: (){
            showOverlay(context);
          },
           style: ElevatedButton.styleFrom(
        primary: Colors.yellow,
        onPrimary: Color(0xff6953F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text('Read SMS', style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic) ,),
    ),
  
      ),
    );
  }
}
