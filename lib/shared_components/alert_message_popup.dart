import 'package:flutter/material.dart';

class AlertMessagePopup extends StatelessWidget {
  const AlertMessagePopup({super.key, required this.title,   required this.isError, this.isSuccess, this.children, this.message});

  final String title;
  final String? message;
  final List<Widget>? children;
  final bool isError;
  final bool? isSuccess;

  _getWindowColor() {
    if(isError == true) {
      return Colors.red;
    }
    if(isSuccess == null || isSuccess == true) {
      return Colors.green;
    }
    return Colors.white;
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getWindowColor(),
      // height: 200,
      padding:const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: isSuccess == true || isError == true ?Colors.white:Colors.black, fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize)),
          message != null ? Text(message!):const Text(""),
          ...?children,
          const SizedBox(height: 48,),
          SizedBox(
            // width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  child: OutlinedButton(

                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    // color: const Color(0xFF1BC0C5),
                    child: Text(
                      "Close",
                      style: TextStyle(color: isSuccess == true || isError == true ?Colors.white:Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}