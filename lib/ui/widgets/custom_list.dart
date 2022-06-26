import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:omar_adel_posts/providers/posts_provider/posts_state.dart';
import '../../helpers/extensions.dart';
import '../../helpers/sized_boxes.dart';
import '../../models/core/post.dart';
import '../../providers/posts_provider/posts_notifier.dart';
import '../../providers/posts_provider/token_repository_provider.dart';
import '../../providers/token_repository_provider.dart';
import '../../theme/dimensions.dart';

class CustomList extends ConsumerStatefulWidget {
  const CustomList({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomList> createState() => _CustomListState();
}

class _CustomListState extends ConsumerState<CustomList> {
  List<Posts> posts = [];

  @override
  Widget build(BuildContext context) {
    posts = ref.watch(postsRepositoryProvider.notifier).posts;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation:10,
              child: Column(
                children: [
                  _iconeRow(posts, index),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      child: Image.memory(
                        base64Decode(posts[index].image!),
                        height: ScreenUtil().setHeight(200),
                        width: ScreenUtil().setWidth(350),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(posts[index].description!,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          color: context.theme.primaryColor,
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _iconeRow(List<Posts> posts, int index) {
    final token = ref.read(tokenRepositoryProvider.notifier).token;
    bool liked = (posts[index].likes?.contains(token)) == true;
    bool saved = (posts[index].saves?.contains(token)) == true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: context.theme.backgroundColor,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: ScreenUtil().setSp(30),
          ),
          radius: 25.0.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
                const Text("")
              ],
            ),
            Column(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: saved == true
                          ? context.theme.primaryColor
                          : context.theme.backgroundColor,
                    ),
                    onPressed: () {
                      if (posts[index].saves != null) {
                        if (saved == false) {
                          posts[index].saves?.add(token);

                        } else {
                          posts[index].saves?.remove(token);

                        }
                        ref
                            .read(postsRepositoryProvider.notifier)
                            .updatePosts(posts);
                        ref
                            .read(postsNotifierProvider.notifier)
                            .updatePost(posts[index]);
                        setState(() {});
                      }
                    }),
                const Text("")
              ],
            ),
            Column(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: liked == true
                          ? context.theme.primaryColor
                          : context.theme.backgroundColor,
                    ),
                    onPressed: () {
                      if (posts[index].likes != null) {
                        if (liked == false) {
                          posts[index].likes?.add(token);
                          ref
                              .read(postsRepositoryProvider.notifier)
                              .updatePosts(posts);
                          ref
                              .read(postsNotifierProvider.notifier)
                              .updatePost(posts[index]);
                        } else {
                          posts[index].likes?.remove(token);
                          ref
                              .read(postsRepositoryProvider.notifier)
                              .updatePosts(posts);
                          ref
                              .read(postsNotifierProvider.notifier)
                              .updatePost(posts[index]);
                        }
                        setState(() {});
                      }
                    }),
                Text(posts[index].likes?.length.toString() ?? "0")
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CustomTextFieldModel {
  final String label;
  final String hint;
  final int? maxLength;
  final Function(String? value)? onSave;
  final String? Function(String? value)? validator;
  final bool isPassword;
  final bool enabled;
  final TextInputType? textInputType;
  final bool enableSuggestions;
  final String initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final int? maxLine;
  final bool isSearch;
  final bool borderInIcon;
  final Function(String)? onChange;

  CustomTextFieldModel({
    this.label = '',
    this.hint = '',
    this.onSave,
    this.validator,
    this.isPassword = false,
    this.enabled = true,
    this.textInputType,
    this.enableSuggestions = false,
    this.initialValue = '',
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.backgroundColor,
    this.maxLine = 1,
    this.isSearch = false,
    this.borderInIcon = false,
    this.onChange,
    this.maxLength,
  });
}
