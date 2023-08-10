import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/UI/home_screen.dart';
import 'package:tic_tac_toe/utils/colors.dart';
import 'package:tic_tac_toe/widgets/progress_indicator.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  late SharedPreferences prefs;

  Future<void> _initSharedPreferences() async {
    //initialize shared prefence on application start up
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _initSharedPreferences();
    Future.delayed(const Duration(milliseconds: 1300)).then((value) =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen(prefs: prefs))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/tic-tac-toe.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
                width: 80,
                child: CustomProgressIndicator(
                  duration: const Duration(milliseconds: 1300),
                ))
          ],
        ),
      ),
    );
  }
}
