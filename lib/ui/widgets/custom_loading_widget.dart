import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';

import '../../helpers/enums.dart';

class CustomLoadingWidget extends StatelessWidget {
  final LoadingType loadingType;
  const CustomLoadingWidget({Key? key, this.loadingType = LoadingType.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loadingType == LoadingType.list
        ? SpinKitThreeBounce(
            color: context.colorScheme.secondary,
            size: 20.h,
          )
        : loadingType == LoadingType.iconButton
            ? SpinKitChasingDots(
                size: 18.h,
                color: context.colorScheme.secondary,
              )
            : const CircularProgressIndicator();
  }
}
