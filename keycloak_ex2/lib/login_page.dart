import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // late Animation<double> _nextPage;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List images = [
    'http://www.sitebuilder.pk/sites/default/files/1.jpg',
    'http://www.sitebuilder.pk/sites/default/files/2.jpg',
    'http://www.sitebuilder.pk/sites/default/files/5.jpg',
    'http://www.sitebuilder.pk/sites/default/files/4_0.jpg',
    'http://www.sitebuilder.pk/sites/default/files/6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    //Start at the controller and set the time to switch pages
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    // _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    //Add listener to AnimationController for know when end the count and change to the next page
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset(); //Reset the controller
        const int page = 5; //Number of pages in your PageView
        if (_currentPage < page) {
          _currentPage++;
          _pageController.animateToPage(_currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInSine);
        } else {
          _currentPage = 0;
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Scaffold(
      body: PageView.builder(
        // allowImplicitScrolling: true,
        controller: _pageController,
        // itemCount: 5,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          print(value);
          //When page change, start the controller
          _animationController.forward();
          _currentPage = value % images.length;
        },
        itemBuilder: (context, index) {
          // print(_currentPage);
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(images[index % images.length]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
