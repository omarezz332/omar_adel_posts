import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../generated/locale_keys.g.dart';
import '../../helpers/extensions.dart';
import '../../ui/dialogs/dialog_container.dart';
import '../../ui/widgets/custom_elevated_button.dart';

class SuccessDialog extends ConsumerWidget {
  final String title;
  final String message;
  final VoidCallback callback;
  const SuccessDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogContainer(
      noCloseIcon: true,
      children: [
        Icon(
          Icons.check_circle,
          color: context.theme.selectedRowColor,
          size: 72,
        ).bottomPadding(8),
        if (title.isNotEmpty)
          Text(
            title,
            style: context.textTheme.headline1!
                .copyWith(color: context.theme.selectedRowColor),
          ).bottomPadding(40.h),
        Text(
          message,
          style: context.textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        CustomElevatedButton(
          width: context.widthR(0.5),
          onTap: () async {
            // close this dialog
            await AutoRouter.of(context).pop();

            // then call back function
            callback();
          },
          title: LocaleKeys.user_actions_ok.tr(),
        ),
      ],
    );
  }
}
void showSuccessDialog(
  BuildContext context,
  String title,
  String message,
  VoidCallback callback,
) =>
    showDialog(
      context: context,
      builder: (_) => SuccessDialog(
        title: title,
        message: message,
        callback: callback,
      ),
    );
