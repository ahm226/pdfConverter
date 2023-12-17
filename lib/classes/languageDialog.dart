import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List locale = [
  {
    'name': 'English',
    'code': 'unitedkingdom',
    'locale': Locale('english', 'ln')
  },
  {'name': 'German', 'code': 'germany', 'locale': Locale('german', 'ln')},
  {'name': 'Korean', 'code': 'southkorea', 'locale': Locale('Korean', 'ln')},
  {'name': 'Italian', 'code': 'italy', 'locale': Locale('italian', 'ln')},
  {
    'name': 'Indonesian',
    'code': 'indonesia',
    'locale': Locale('Indonesian', 'ln')
  },
  {'name': 'Japanese', 'code': 'japan', 'locale': Locale('Japanese', 'ln')},
  {'name': 'Russian', 'code': 'russia', 'locale': Locale('Russian', 'ln')},
  {
    'name': 'Portuguese',
    'code': 'portugal',
    'locale': Locale('Portuguese', 'ln')
  },
  {'name': 'Spanish', 'code': 'spain', 'locale': Locale('Spanish', 'ln')},
];

class LanguageChangeDialog {
  static void buildDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              "Choose a language",
              style: TextStyle(
                fontFamily: "DM Sans",
                color: Color(0xff1C2978),
              ),
            ),
            content: Container(
              width: double.infinity,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      updateLanguage(locale[index]['locale']);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/${locale[index]['code'].toLowerCase()}.png', // Use the correct file name for each country
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: 17,
                        ),
                        Text(
                          locale[index]['name'],
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: locale.length,
              ),
            ),
          );
        });
  }
}

updateLanguage(Locale locale) async {
  await saveSelectedLocale(locale);

  Get.back();
  Get.updateLocale(locale);
}

Future<void> saveSelectedLocale(Locale locale) async {
  final preferences = await SharedPreferences.getInstance();
  await preferences.setString('selected_locale', locale.toString());
}
