

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';
import 'package:omar_adel_posts/helpers/fields_validator.dart';
import 'package:omar_adel_posts/models/core/login_data.dart';
import 'package:omar_adel_posts/models/core/login_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/ui/widgets/custom_text_field.dart';

import '../../data/remote/apis/authentication_api.dart';
import '../../generated/locale_keys.g.dart';
import '../../helpers/ui_helpers.dart';
import '../../providers/authentication_provider/authentication_notifier.dart';
import '../../providers/authentication_provider/authentication_state.dart';
import '../../providers/fields_providers/login_field_provider.dart';
import '../../providers/fields_providers/register_field_provider.dart';
import '../../router/custom_router.gr.dart';
import '../widgets/custom_elevated_button.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final fieldProvider = ref.read(loginFieldProviderRef);
    ref.listen<AuthenticationState>(authenticationNotifierProvider,
        (previous, next) {
      if (next is Authenticated && previous != next) {
        UiHelpers.postBuildCallback((p0) {
          Future.delayed(const Duration(milliseconds: 100), () {
            AutoRouter.of(context).pushAndPopUntil(
              const HomeRoute(),
              predicate: (_) => false,
            );
          });
        });
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Form(
            key: fieldProvider.loginKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [

                CustomTextField(
                  customTextFieldModel: CustomTextFieldModel(
                    validator: (value) => value!
                        .trim()
                        .validate([validateRequired, validateEmail]),
                    textInputType: TextInputType.emailAddress,
                    label: LocaleKeys.user_actions_email.tr(),
                    borderInIcon: true,
                    prefixIcon: const Icon(Icons.mail_outline),
                    onSave: (value) => fieldProvider.setEmail(value!.trim()),
                  ),
                ),
                CustomTextField(
                  customTextFieldModel: CustomTextFieldModel(
                    isPassword: true,
                    validator: (value) =>
                        value!.validate([validateRequired, validatePassword]),
                    label: LocaleKeys.user_actions_password.tr(),
                    borderInIcon: true,
                    prefixIcon: const Icon(Icons.lock_open),
                    onSave: (value) => fieldProvider.setPassword(value!),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: TextButton(
                      onPressed: () {

                      },
                          // AutoRouter.of(context)
                          // .push(const ForgetPasswordRoute()),
                      child: Text(LocaleKeys.user_actions_forget_password.tr()),
                    ),
                  ),
                ),
                Consumer(
                  builder: (_, ref, __) {
                    final loading = ref.watch(authenticationNotifierProvider)
                    is AuthenticationLoading;
                    return CustomElevatedButton(
                      loading: loading,
                      onTap: () {
                        if (fieldProvider.validate()) {
                          ref
                              .read(authenticationNotifierProvider.notifier)
                              .login();
                        }
                      },
                      width: context.widthR(0.5),
                      title: LocaleKeys.user_actions_login.tr().toUpperCase(),
                    );
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleKeys.alerts_do_not_have_account.tr(),
                      style: context.textTheme.headline5,
                    ),
                    TextButton(
                      onPressed: () =>
                          AutoRouter.of(context).push(const RegisterRoute()),
                      child: Text(
                        LocaleKeys.user_actions_sign_up_now.tr(),
                        style: context.textButtonUnderLine,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
//widget signup with email and password

}

Widget _signUpWithEmailAndPassword() {
  return Column(
    children: <Widget>[
      const TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      const TextField(
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      ElevatedButton(
        child: const Text('Sign Up'),
        onPressed: () {},
      ),
    ],
  );
}
