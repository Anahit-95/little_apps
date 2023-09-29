import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LoginPageTwo extends StatelessWidget {
  final Future Function() login;
  const LoginPageTwo({super.key, required this.login});

  final List images = const [
    'http://www.sitebuilder.pk/sites/default/files/1.jpg',
    'http://www.sitebuilder.pk/sites/default/files/2.jpg',
    'http://www.sitebuilder.pk/sites/default/files/5.jpg',
    'http://www.sitebuilder.pk/sites/default/files/4_0.jpg',
    'http://www.sitebuilder.pk/sites/default/files/6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1A5073),
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: double.maxFinite,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayCurve: Curves.decelerate,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    ),
                    items: images.map((i) {
                      return Builder(
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(i),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * .6,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A5073).withOpacity(.6),
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
                      color: Colors.black.withOpacity(.7),
                      child: const Column(
                        children: [
                          Text(
                            'Welcome to Vipilink',
                            style: TextStyle(
                              fontSize: 36,
                              fontFamily: 'Times New Roman',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Build, Manage & Monitor your Secure Private Infrastructure',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFFFFFFF),
            foregroundColor: const Color(0xFF1A5073),
            side: const BorderSide(width: 2, color: Colors.white),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 3,
            shadowColor: const Color(0xFF7E7E7E),
          ),
          onPressed: login,
          child: const Text(
            'GET STARTED',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ),
      ),
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       border: Border.all(width: 2, color: Colors.white),
      //       borderRadius: BorderRadius.circular(5),
      //       boxShadow: const [
      //         BoxShadow(
      //           offset: Offset(0, 0),
      //           color: Color(0xFF7E7E7E),
      //           spreadRadius: 3,
      //           blurRadius: 2,
      //         ),
      //       ]),
      //   width: MediaQuery.of(context).size.width * .8,
      //   child: TextButton(
      //     style: TextButton.styleFrom(
      //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //       foregroundColor: const Color(0xFF1A5073),
      //     ),
      //     onPressed: login,
      //     child: const Text(
      //       'GET STARTED',
      //       style: TextStyle(
      //         fontSize: 15,
      //         fontWeight: FontWeight.bold,
      //         height: 1.4,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
