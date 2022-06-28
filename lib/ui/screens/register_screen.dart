import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_left.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up_big.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';
import 'package:omar_adel_posts/helpers/fields_validator.dart';

import '../../generated/locale_keys.g.dart';
import '../../helpers/ui_helpers.dart';
import '../../providers/authentication_provider/register_notifier.dart';
import '../../providers/fields_providers/register_field_provider.dart';
import '../dialogs/success_dialog.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final fieldProvider = ref.read(registerFieldProviderRef);
    return Scaffold(
      backgroundColor: context.colorScheme.background,

      appBar: AppBar(
        foregroundColor:context.theme.primaryColor,

        backgroundColor: context.colorScheme.background,
        elevation: 0,
        title: FadeInLeft(
            child: Text(LocaleKeys.user_actions_register.tr(),style: TextStyle(color: context.theme.primaryColor,),)),),
      body: FadeInUpBig(
        preferences: AnimationPreferences(
          duration: Duration(milliseconds: 500),

        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Form(
              key: fieldProvider.registerKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [

                  CustomTextField(
                    customTextFieldModel: CustomTextFieldModel(
                      validator: (value) => value!.validate([validateRequired]),
                      label: LocaleKeys.user_actions_full_name.tr(),

                      // onSave: (value) => fieldProvider.(value!),
                    ),
                  ),
                  CustomTextField(
                    customTextFieldModel: CustomTextFieldModel(
                      validator: (value) => value!
                          .trim()
                          .validate([validateRequired, validateEmail]),
                      label: LocaleKeys.user_actions_email.tr(),

                      onSave: (value) => fieldProvider.setEmail(value!.trim()),
                    ),
                  ),
                  CustomTextField(
                    customTextFieldModel: CustomTextFieldModel(
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) =>
                          value!.validate([validateRequired, validatePassword]),
                      label: LocaleKeys.user_actions_password.tr(),

                      onSave: (value) => fieldProvider.setPassword(value!),
                    ),
                  ),
                  CustomTextField(
                    customTextFieldModel: CustomTextFieldModel(
                      isPassword: true,
                      validator: (value) =>
                          matchesPasswords(value!, passwordController.text),
                      label: LocaleKeys.user_actions_password_confirmation.tr(),

                     // onSave: (value) =>
                          //fieldProvider.setPasswordConfirmation(value!),
                    ),
                  ),
                  Consumer(
                    builder: (_, ref, __) {
                      return CustomElevatedButton(
                        loading: ref.watch(registerNotifierProviderRef),
                        onTap: () async {
                          if (fieldProvider.validate()) {
                            // wait request from notifier
                         await ref
                                .read(registerNotifierProviderRef.notifier)
                                .register();

                              // show dialog if message is not empty
                         if(ref
                             .read(registerNotifierProviderRef.notifier).state) {
                           UiHelpers.postBuildCallback((p0) {
                             showSuccessDialog(
                                 context,
                                 LocaleKeys.user_actions_register_successfully
                                     .tr(),
                                 " ", () {
                               AutoRouter.of(context).pop();
                             });
                           });
                         }
                         else
                           {
                              UiHelpers.postBuildCallback((p0) {
                                showSuccessDialog(
                                    context,
                                    LocaleKeys.user_actions_register
                                        .tr(),
                                    " ", () {
                                  AutoRouter.of(context).pop();
                                });
                              });
                           }

                          }
                        },
                        width: context.widthR(0.5),
                        title: LocaleKeys.user_actions_signup.tr().toUpperCase(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
