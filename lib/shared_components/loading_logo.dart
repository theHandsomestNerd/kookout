import 'package:flutter/material.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: SizedBox(
            height: 150,
            width: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 128,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      minHeight: 50,
                      color: Color(0xffd50032),
                    )),
              ],
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 150,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/splash_top_logo.png'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
