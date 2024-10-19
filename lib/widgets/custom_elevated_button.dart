import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/values/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? height;
  final bool isLoading;
  final bool isSeeNextIcon;
  final String title;
  final IconData? icon;
  final String? iconSvg;
  final VoidCallback? onTap;
  final TextStyle? style;

  const CustomElevatedButton(
      {super.key,
      this.height,
      this.isLoading = false,
      this.isSeeNextIcon = false,
      required this.title,
      this.icon,
      this.iconSvg,
      this.onTap,
      this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        maximumSize: Size(double.infinity, height ?? 48),
        minimumSize: Size(double.infinity, height ?? 48),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.mainColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Gilroy',
        ),
      ),
    );
  }
}
