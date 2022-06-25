import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';
import '../../generated/locale_keys.g.dart';
import '../../helpers/fields_validator.dart';
import '../../helpers/ui_helpers.dart';
import '../../providers/authentication_provider/authentication_notifier.dart';
import '../../providers/fields_providers/post_field_provider.dart';
import '../../providers/posts_provider/posts_notifier.dart';
import '../../providers/posts_provider/posts_state.dart';
import '../../router/custom_router.gr.dart';
import '../../ui/dialogs/dialog_container.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreatePostDialog extends ConsumerStatefulWidget {
  const CreatePostDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<CreatePostDialog> createState() => _createPostDialog();
}

class _createPostDialog extends ConsumerState<CreatePostDialog> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    String? profilePhoto = ref.watch(postFieldProviderRef).getImage();
    final loading = ref.watch(authenticationNotifierProvider);
    return SingleChildScrollView(
      child: DialogContainer(
        //  title: LocaleKeys.alerts_logout.tr(),
        children: [
          SingleChildScrollView(
            child: Expanded(
              child: Form(
                key: ref.read(postFieldProviderRef).postKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final xFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (xFile != null) {
                          final file = File(xFile.path);
                          List<int> imageBytes = file.readAsBytesSync();
                          print(imageBytes);
                          String base64Image = base64Encode(imageBytes);
                          setState(() {
                            profilePhoto = base64Image;
                          });

                          ref
                              .read(postFieldProviderRef)
                              .setImage(profilePhoto!);
                        } else {}
                      },
                      child: profilePhoto != null
                          ? Image.memory(
                              base64Decode(profilePhoto!),
                              height: ScreenUtil().setHeight(200),
                              width: ScreenUtil().setWidth(400),
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: context.colorScheme.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Card(
                                color: context.theme.backgroundColor,
                                child: Center(
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: context.theme.iconTheme.color,
                                    size: 50.sp,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    CustomTextField(
                      customTextFieldModel: CustomTextFieldModel(
                        validator: (value) => value!
                            .trim()
                            .validate([validateRequired, maxPostTextLength]),
                        textInputType: TextInputType.multiline,
                        maxLength: 200,
                        maxLine: 4,
                        label: LocaleKeys.user_actions_write_commint.tr(),
                        onSave: (value) => ref
                            .read(postFieldProviderRef)
                            .setDescription(value!),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: context.colorScheme.secondary,
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => AutoRouter.of(context).pop(),
                            child: Text(LocaleKeys.user_actions_ignore.tr()),
                          ),
                        ),
                        Consumer(
                          builder: (_, ref, __) {
                            final fieldProvider = ref.read(postFieldProviderRef);
                            final loading = ref.watch(postsNotifierProvider)
                            is PostsLoading ;
                            return      Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      context.colorScheme.secondary),
                                  textStyle: MaterialStateProperty.all(TextStyle(
                                      color: context.colorScheme.onBackground,
                                      fontSize: 25.sp)),
                                ),
                                onPressed: () async {
                                  if (fieldProvider.validate()) {
                                     await ref.read(postsNotifierProvider.notifier).addPost();
                                    if(ref.watch(postsNotifierProvider)
                                    is Posted){

                                        AutoRouter.of(context).pop();

                                    }

                                  }


                                },
                                child: loading?SpinKitThreeBounce(
                                  color: context.theme.canvasColor,
                                  size: 20,
                                ):Text(LocaleKeys.user_actions_publish.tr()),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void showLogoutAlertDialog(BuildContext context) =>
    showDialog(context: context, builder: (_) => const CreatePostDialog());
