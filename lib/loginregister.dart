import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  

  List<Widget> _pages = [
    OnboardingPage(
      title: 'Welcome to Expenzo',
      description: 'It is simple and intuitive.\nLog any transaction within seconds\nstay on top of your money.',
      backgroundImage: 'lib/assets/splash7.jpg',
    ),
    OnboardingPage(
      title: 'Get detailed analysis',
      description: 'Efficiently monitor your spending habits and always make better & informed decisions with your money!',
      backgroundImage: 'lib/assets/splash8.jpg',
    ),
    OnboardingPage(
      title: 'Achieve Your Financial Goals',
      description: 'Stay on Track with budgets. Create a budget and get future predictions if you are overshoot.',
      showButtons: true,
      backgroundImage: 'lib/assets/splash9.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemBuilder: (context, index) {
            return _pages[index];
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.orange,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _pages.length; i++)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 10,
                width: (i == _currentPage) ? 30 : 10,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: (i == _currentPage) ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final bool showButtons;
  final String backgroundImage;

  const OnboardingPage({
    required this.title,
    required this.description,
    this.showButtons = false,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0), // Adjust the top padding value
            child: Row(
              children: [
                Image.asset(
                  'lib/assets/ET.png',
                  width: 70,
                  height: 70,
                ),
                SizedBox(width: 8),
                Text(
                  'Expenzo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (showButtons)
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Button background color
                            onPrimary: Colors.black, // Button text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Rounded edges
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          ),
                          onPressed: () {
                            // Handle "Get Started" button press
                            Navigator.pushNamed(context, 'register');
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
