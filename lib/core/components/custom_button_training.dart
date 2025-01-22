import 'package:flutter/material.dart';
import '../core.dart';

class CustomButtonTraining extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Widget? prefixIcon;
  final Color? BackgroundColor;

  const CustomButtonTraining({
    required this.onPressed,
    super.key,
    required this.title,
    this.prefixIcon,
    this.BackgroundColor = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: BackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        minimumSize: const Size.fromHeight(55),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIcon ?? Container(),
          const SpaceWidth(10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              backgroundColor: AppColors.blue,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
