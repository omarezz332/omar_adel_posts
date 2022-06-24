import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../generated/locale_keys.g.dart';
import '../../helpers/ui_helpers.dart';
import '../../providers/authentication_provider/authentication_notifier.dart';
import '../../router/custom_router.gr.dart';
import '../../ui/dialogs/dialog_container.dart';

class LogoutAlertDialog extends ConsumerWidget {
  const LogoutAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogContainer(
      title: LocaleKeys.alerts_logout.tr(),
      children: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () async {
                  await ref
                      .read(authenticationNotifierProvider.notifier)
                      .logout();

                  UiHelpers.postBuildCallback((p0) {
                    AutoRouter.of(context).pushAndPopUntil(
                      const AuthRoute(),
                      predicate: (_) => false,
                    );
                  });
                },
                child: Text(LocaleKeys.user_actions_yes.tr()),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () => AutoRouter.of(context).pop(),
                child: Text(LocaleKeys.user_actions_cancel.tr()),
              ),
            ),
          ],
        )
      ],
    );
  }
}

void showLogoutAlertDialog(BuildContext context) =>
    showDialog(context: context, builder: (_) => const LogoutAlertDialog());
