import 'package:flutter/material.dart';
import 'package:loginflutter/FileAdapter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class PassbookPage extends StatefulWidget {
  const PassbookPage({Key? key}) : super(key: key);

  @override
  State<PassbookPage> createState() => _PassbookPageState();
}

class _PassbookPageState extends State<PassbookPage> {
  bool isFirstTime = true;
  bool isGreenBoxVisible = true;
  int selectedDay = 1;
  String selectedEntryType = '';
  String? selectedPdfPath;
  String? selectedCsvPath;
  List<String> pdfNames = [];
  List<String> csvNames = [];
   Box<String>? fileBox;

  @override
  void initState() {
    super.initState();
    checkPermission();
    initializeHive();
    loadFilesFromHive();
  }

  void checkPermission() async {
    PermissionStatus status = await Permission.sms.status;

    if (status.isDenied && isFirstTime) {
      status = await Permission.sms.request();

      if (status.isGranted) {
        Fluttertoast.showToast(msg: 'SMS permission granted');
      } else {
        Fluttertoast.showToast(msg: 'SMS permission denied');
      }

      setState(() {
        isFirstTime = false;
      });
    }
  }

  void initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FileAdapter());
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.openBox<String>('files', path: appDocumentDir.path);
    fileBox = Hive.box<String>('files');
  }

  void loadFilesFromHive() {
    setState(() {
      pdfNames = fileBox?.values.toList() ?? [];
      csvNames = fileBox?.values.toList() ?? [];
    });
  }

  Future<void> choosePDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      setState(() {
        selectedPdfPath = file.path;
        String pdfName = path.basename(selectedPdfPath!);
        pdfNames.add(pdfName);
      });

      // Store file path in Hive
      fileBox?.add(selectedPdfPath!);
    }
  }

  Future<void> chooseCSV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xls', 'xlsx'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      setState(() {
        selectedCsvPath = file.path;
        String csvName = path.basename(selectedCsvPath!);
        csvNames.add(csvName);
      });

      // Store file path in Hive
      fileBox?.add(selectedCsvPath!);
    }
  }

  void openPDF(int index) async {
    if (selectedPdfPath != null) {
      String path = selectedPdfPath!;
      await OpenFile.open(path);
    }
  }

  void openCSV(int index) async {
    if (selectedCsvPath != null) {
      String path = selectedCsvPath!;
      await OpenFile.open(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<String>('files'),
      builder: (BuildContext context, AsyncSnapshot<Box<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            fileBox = snapshot.data!;
          }
          return buildPassbookPage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildPassbookPage() {
    if (fileBox == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
                'Passbook',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(width: 140),
              GestureDetector(
                child: Icon(Icons.more_sharp),
                onTap: () {
                  Navigator.pushNamed(context, 'psettings');
                },
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            if (isGreenBoxVisible)
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
              child: ListView.builder(
                itemCount: pdfNames.length + csvNames.length,
                itemBuilder: (context, index) {
                  if (index < pdfNames.length) {
                    return buildPDFItem(index);
                  } else {
                    return buildCSVItem(index - pdfNames.length);
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: chooseCSV,
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Color(0xff6953F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Read CSV',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: choosePDF,
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Color(0xff6953F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Read PDF',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPDFItem(int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        String filePath = fileBox!.getAt(index)!;
        setState(() {
          fileBox!.deleteAt(index);
          pdfNames.removeAt(index);
        });
        Fluttertoast.showToast(msg: 'Deleted file: $filePath');
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            pdfNames[index],
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onTap: () => openPDF(index),
        ),
      ),
    );
  }

  Widget buildCSVItem(int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        String filePath = fileBox!.getAt(index + pdfNames.length)!;
        setState(() {
          fileBox!.deleteAt(index + pdfNames.length);
          csvNames.removeAt(index);
        });
        Fluttertoast.showToast(msg: 'Deleted file: $filePath');
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            csvNames[index],
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onTap: () => openCSV(index),
        ),
      ),
    );
  }
}
