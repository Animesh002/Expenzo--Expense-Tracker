import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({Key? key}) : super(key: key);

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  String selectedLanguage = 'English'; // Initial selected language
  String selectedTheme = 'Default'; // Initial selected theme
  String selectedCurrency = 'INR'; // Initial selected currency
  String selectedSortOption = 'Ascending Date'; // Initial selected sort option
  bool isCalculatorOpen = false; // Whether the calculator is open or not
  bool isAutoCompleteEnabled = false; // Whether auto complete is enabled or not

  // List of available languages
  List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Portuguese',
    'Chinese',
    // Add more languages as needed
  ];

  // List of available themes
  List<String> themes = [
    'Light',
    'Dark',
    'Default',
    // Add more themes as needed
  ];

  // List of available currencies
  List<String> currencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'INR',
    // Add more currencies as needed
  ];

  // List of available sort options
  List<String> sortOptions = [
    'Ascending Date',
    'Descending Date',
    'Included Order',
    'Expense Type',
    'Description',
    // Add more sort options as needed
  ];

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
          leading: BackButton(),
          title: Row(
            children: [
              Text(
                'Preference',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 24.0, // Increased font size
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.black54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Choose a Language',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0, // Increased font size
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Expanded(
                              child: ListView.builder(
                                itemCount: languages.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedLanguage = languages[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        languages[index],
                                        style: TextStyle(
                                          color: selectedLanguage == languages[index]
                                              ? Colors.blue
                                              : Colors.white,
                                          fontSize: 18.0, // Increased font size
                                        ),
                                      ),
                                      trailing: selectedLanguage == languages[index]
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.blue,
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: Colors.white,
                      size: 30.0, // Increased icon size
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Language',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      selectedLanguage,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Added gap
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.black54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Choose a Theme',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0, // Increased font size
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Expanded(
                              child: ListView.builder(
                                itemCount: themes.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTheme = themes[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        themes[index],
                                        style: TextStyle(
                                          color: selectedTheme == themes[index]
                                              ? Colors.blue
                                              : Colors.white,
                                          fontSize: 18.0, // Increased font size
                                        ),
                                      ),
                                      trailing: selectedTheme == themes[index]
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.blue,
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.color_lens,
                      color: Colors.white,
                      size: 30.0, // Increased icon size
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Theme',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      selectedTheme,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Added gap
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.black54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Choose a Currency',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0, // Increased font size
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Expanded(
                              child: ListView.builder(
                                itemCount: currencies.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCurrency = currencies[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        currencies[index],
                                        style: TextStyle(
                                          color: selectedCurrency == currencies[index]
                                              ? Colors.blue
                                              : Colors.white,
                                          fontSize: 18.0, // Increased font size
                                        ),
                                      ),
                                      trailing: selectedCurrency == currencies[index]
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.blue,
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.white,
                      size: 30.0, // Increased icon size
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Currency',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      selectedCurrency,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Added gap
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.black54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Choose a Sort Option',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0, // Increased font size
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Expanded(
                              child: ListView.builder(
                                itemCount: sortOptions.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSortOption = sortOptions[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        sortOptions[index],
                                        style: TextStyle(
                                          color: selectedSortOption == sortOptions[index]
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 18.0, // Increased font size
                                        ),
                                      ),
                                      trailing: selectedSortOption == sortOptions[index]
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.black,
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: Colors.white,
                      size: 30.0, // Increased icon size
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Sort Option',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      selectedSortOption,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0, // Increased font size
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Added gap
              Row(
                children: [
                  Icon(
                    isCalculatorOpen ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Colors.white,
                    size: 30.0, // Increased icon size
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Open Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0, // Increased font size
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Switch(
                    value: isCalculatorOpen,
                    onChanged: (value) {
                      setState(() {
                        isCalculatorOpen = value;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: 16.0), // Added gap
              Row(
                children: [
                  Icon(
                    isAutoCompleteEnabled ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Colors.white,
                    size: 30.0, // Increased icon size
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Enable Auto Complete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0, // Increased font size
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Switch(
                    value: isAutoCompleteEnabled,
                    onChanged: (value) {
                      setState(() {
                        isAutoCompleteEnabled = value;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preference Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'), // Spanish
        const Locale('fr'), // French
        const Locale('de'), // German
        const Locale('it'), // Italian
        const Locale('pt'), // Portuguese
        const Locale('zh'), // Chinese
        // Add more supported locales as needed
      ],
      home: PreferencePage(),
    );
  }
}