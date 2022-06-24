import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../helpers/extensions.dart';
import '../../theme/dimensions.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final TextStyle? style;
  final VoidCallback onTap;
  final bool loading;
  final double? width;
  final double? radius;
  final IconData? iconData;
  const CustomElevatedButton({
    Key? key,
    required this.onTap,
    this.buttonColor,
    this.style,
    required this.title,
    this.loading = false,
    this.width,
    this.radius,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(

        onPressed: () {

          context.closeKeyboard();
          onTap();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            buttonColor ?? context.theme.colorScheme.secondary,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            context.theme.colorScheme.background,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
              color:Colors.white,
            )
          ),
          fixedSize:
              MaterialStateProperty.all(Size(width ?? context.width, 45.h)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? kRadiusLarge),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: loading
              ? SpinKitThreeBounce(
                  color: context.theme.canvasColor,
                  size: 20,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (iconData != null)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: Icon(iconData),
                      ),
                    Text(
                      title,
                      style: style ??
                          context.textTheme.button!
                              .copyWith(color: context.theme.canvasColor),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
