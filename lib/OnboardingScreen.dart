import 'package:flutter/material.dart';
import 'package:veterinaria_flutter/LoginPage.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);
  int _currentPage = 0;
  bool _showBackButton = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _showBackButton = index > 0;
              });
            },
            children: [
              _buildPage(
                image:
                    'https://papelmatic.com/wp-content/uploads/2019/09/papelmatic-higiene-profesional-limpieza-desinfeccion-clinicas-veterinarias.jpg',
                title: '𝐖𝐞𝐥𝐜𝐨𝐦𝐞 𝐭𝐨 𝐭𝐡𝐞 𝐯𝐞𝐭𝐞𝐫𝐢𝐧𝐚𝐫𝐲 𝐜𝐥𝐢𝐧𝐢𝐜',
                subtitle: '𝐃𝐢𝐬𝐜𝐨𝐯𝐞𝐫 𝐨𝐮𝐫 𝐯𝐞𝐭𝐞𝐫𝐢𝐧𝐚𝐫𝐲 𝐦𝐚𝐧𝐚𝐠𝐞𝐦𝐞𝐧𝐭 𝐚𝐩𝐩𝐥𝐢𝐜𝐚𝐭𝐢𝐨𝐧',
              ),
              _buildPage(
                image:
                    'https://www.ventasdealtooctanaje.com/wp-content/uploads/2023/08/Plan-para-la-gestion-de-clientes-1200x720.jpg',
                title: '𝐌𝐚𝐧𝐚𝐠𝐞 𝐲𝐨𝐮𝐫 𝐜𝐥𝐢𝐞𝐧𝐭𝐬',
                subtitle: '𝐌𝐚𝐧𝐚𝐠𝐞 𝐲𝐨𝐮𝐫 𝐜𝐥𝐢𝐞𝐧𝐭𝐬 𝐞𝐟𝐟𝐢𝐜𝐢𝐞𝐧𝐭𝐥𝐲',
              ),
              _buildPage(
                image:
                    'https://purina.com.mx/sites/default/files/2022-10/purina-esterilizaci%C3%B3n-de-mascotas.jpg',
                title: '𝐑𝐞𝐠𝐢𝐬𝐭𝐫𝐚𝐭𝐢𝐨𝐧 𝐨𝐟 𝐜𝐨𝐧𝐬𝐮𝐥𝐭𝐚𝐭𝐢𝐨𝐧𝐬 𝐚𝐧𝐝 𝐩𝐞𝐭𝐬',
                subtitle: '𝐑𝐞𝐠𝐢𝐬𝐭𝐞𝐫 𝐪𝐮𝐞𝐫𝐢𝐞𝐬 𝐚𝐧𝐝 𝐩𝐞𝐭𝐬 𝐞𝐚𝐬𝐢𝐥𝐲',
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
          Visibility(
            visible: _showBackButton,
            child: Positioned(
              bottom: 70,
              left: 16,
              child: FloatingActionButton(
                onPressed: () {
                  if (_currentPage > 0) {
                    _pageController.animateToPage(
                      _currentPage - 1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
                    Positioned(
            bottom: 70,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                if (_currentPage > 0) {
                  _pageController.animateToPage(
                    _currentPage - 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              backgroundColor: Colors.blueGrey, // Cambiar el color del botón aquí
              child: Icon(Icons.arrow_back),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                if (_currentPage < 2) {
                  _pageController.animateToPage(
                    _currentPage + 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              },
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.arrow_forward),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildPage(
      {required String image,
      required String title,
      required String subtitle}) {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(image, height: 200),
          SizedBox(height: 40),
          Text(title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text(subtitle,
              style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage ? Colors.blueGrey : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
