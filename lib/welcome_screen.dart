import 'package:flutter/material.dart';
import '/login_screen.dart';
import '/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  final Function onNext;
  final String? username;
  final bool isOwner;
  final bool showNoMoreButton;

  const WelcomeScreen({
    Key? key,
    required this.onNext,
    this.username,
    this.isOwner = false,
    required this.showNoMoreButton,
  }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    _WelcomePage(
      title: 'Bienvenido a Rider Chile',
      description: 'La app que te conecta con traslados rápidos, seguros y económicos.',
      imageAsset: 'assets/images/rider_intro_1.png',
    ),
    _WelcomePage(
      title: 'Viaja donde quieras',
      description: 'Pide un viaje desde tu ubicación actual o programa uno a futuro.',
      imageAsset: 'assets/images/rider_viaje.png',
    ),
    _WelcomePage(
      title: 'Más que traslados',
      description: 'Encarga tu medicamento, lleva a tu mascota o solicita ayuda.',
      imageAsset: 'assets/images/rider_servicios.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() => _currentPage = index);
                },
                children: _pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.username != null && widget.showNoMoreButton)
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('show_welcome_screen', false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViajesScreen(userEmail: widget.username!),
                        ),
                      );
                    },
                    child: const Text('No mostrar más'),
                  ),
                Row(
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                      width: _currentPage == index ? 16.0 : 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? Colors.blueAccent : Colors.grey,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // 🔒 Aquí puedes validar si hay sesión o rol, y redirigir adecuadamente
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.username == null
                              ? const LoginScreen()
                              : ViajesScreen(userEmail: widget.username!),
                        ),
                      );
                    }
                  },
                  child: Text(_currentPage < _pages.length - 1 ? 'Siguiente' : 'Comenzar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  const _WelcomePage({
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAsset,
            height: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(height: 32.0),
          Text(
            title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
