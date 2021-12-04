import 'package:flutter/material.dart';
import '../utilities/utilities.dart';

class InfoDialog extends StatelessWidget {
  final String status;
  final String detail;
  final String buttonText;
  final VoidCallback buttonPressed;

  const InfoDialog({
    Key? key,
    this.status = 'Warning',
    this.buttonText = 'Cancel',
    required this.detail,
    required this.buttonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding,
          ),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(status, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(detail, textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                // ignore: unnecessary_null_comparison
                child: buttonPressed != null
                    ? TextButton(
                        onPressed: buttonPressed,
                        child: Text(buttonText),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(Constants.avatarRadius),
              ),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/launchers/ksmart-transparent-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
