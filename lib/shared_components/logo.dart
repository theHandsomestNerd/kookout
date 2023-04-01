import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 100,child: Image.asset('assets/logo.png'),);
  }
}
