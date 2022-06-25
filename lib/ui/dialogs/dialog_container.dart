import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../helpers/extensions.dart';
import '../../theme/dimensions.dart';

class DialogContainer extends StatefulWidget {
  final Color? backgroundColor;
  final bool noCloseIcon;
  final List<Widget> children;
  final String title;
  const DialogContainer({
    Key? key,
    this.backgroundColor,
    this.noCloseIcon = false,
    this.title = '',
    this.children = const [],
  }) : super(key: key);

  @override
  State<DialogContainer> createState() => _DialogContainerState();
}

class _DialogContainerState extends State<DialogContainer> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor ?? context.colorScheme.surface,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(bottom: kSizeSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusMedium),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.noCloseIcon)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: IconButton(
                onPressed: () => context.popRoute(),
                icon: const Icon(Icons.close),
              ),
            ),
          if (widget.title.isNotEmpty)
            Text(
              widget.title,
              style: context.textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
        ],
      ),
      content: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: context.width,
                child: Column(
                  children: widget.children,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
