import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton(
      {super.key, required this.action, this.text, this.isLoading, this.isDisabled, this.width});

  final Function action;
  final double? width;
  final bool? isLoading;
  final bool? isDisabled;
  final String? text;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      color: Theme.of(context).colorScheme.secondary,
      disabledColor: Colors.black12,
      textColor: Colors.white,
      onPressed: isDisabled == true ? null : ()async {await action(context);},
      child: SizedBox(
        key: Key(isLoading.toString()),
        height: 48,
        width: width??200,
        child: isLoading == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                    SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text ?? ""),
                ],
              ),
      ),
    );
  }
}
