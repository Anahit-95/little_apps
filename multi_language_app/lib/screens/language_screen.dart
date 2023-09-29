import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_language_app/controller/language_controller.dart';

import 'language_widget.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GetBuilder<LocalizationController>(
        builder: (localizationController) {
          return Column(
            children: [
              Expanded(
                  child: Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              'img/logo.png',
                              width: 120,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: Image.asset(
                              'img/logo2.png',
                              width: 100,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'select_language'.tr,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => LanguageWidget(
                                    languageModel:
                                        localizationController.languages[index],
                                    localizationController:
                                        localizationController,
                                    index: index,
                                  )),
                          const SizedBox(height: 10),
                          Text('you_can_change_language'.tr)
                        ],
                      ),
                    )),
                  ),
                ),
              ))
            ],
          );
        },
      )),
    );
  }
}
