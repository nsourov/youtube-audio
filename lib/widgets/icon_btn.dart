import 'package:flutter/material.dart';
import 'package:youtube_audio/utils/constants.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({
    super.key,
    required this.icon,
    required this.onPress,
    this.large = false,
    this.active = false,
  });

  final bool large;
  final bool active;
  final IconData icon;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
            color: active ? kSecondaryColor : kBorderColor,
            width: 1,
          ),
          color: active ? kSecondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(50.0),
        ), //<-- SEE HERE
        child: InkWell(
          borderRadius: BorderRadius.circular(100.0),
          onTap: onPress,
          child: Padding(
            padding: EdgeInsets.all(large ? 20.0 : 10.0),
            child: Icon(
              icon,
              size: large ? 40.0 : 25.0,
            ),
          ),
        ),
      ),
    );
  }
}
