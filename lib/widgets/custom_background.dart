import 'package:flutter/material.dart';
import 'package:psychology_mobile/common/values/colors.dart';
import 'package:psychology_mobile/common/values/images.dart';

class CustomBackground extends StatelessWidget {
  final bool isGradient;
  final Widget child;

  const CustomBackground({super.key, this.isGradient = true, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(isGradient ? AppImages.gradient : AppImages.back),
          fit: BoxFit.fill
        ),
        gradient: isGradient ? LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.c1A1F37.withOpacity(0.5),
            AppColors.c1A1F37.withOpacity(0.5),
          ],
        ) : null,
      ),
      child: child,
    );
  }
}
