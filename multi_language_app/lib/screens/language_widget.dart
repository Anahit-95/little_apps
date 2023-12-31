import 'package:flutter/material.dart';
import 'package:multi_language_app/controller/language_controller.dart';
import 'package:multi_language_app/utils/app_constants.dart';

import '../models/language_model.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;

  const LanguageWidget(
      {required this.languageModel,
      required this.localizationController,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(Locale(
            AppConstants.languages[index].languageCode,
            AppConstants.languages[index].countryCode));
        localizationController.setSelectIndex(index);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
        ),
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5),
                Text(languageModel.languageName),
              ],
            ),
          ),
          localizationController.selectedIndex == index
              ? Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 40,
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : SizedBox(),
        ]),
      ),
    );
  }
}
