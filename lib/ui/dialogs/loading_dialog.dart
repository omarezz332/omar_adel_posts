import 'package:flutter/material.dart';
import '../../ui/widgets/custom_loading_widget.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CustomLoadingWidget(),
        ],
      ),
    );
  }
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const LoadingDialog(),
    barrierDismissible: false,
  );
}
