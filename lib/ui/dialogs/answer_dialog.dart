import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../generated/locale_keys.g.dart';
import '../../helpers/extensions.dart';
import '../../theme/dimensions.dart';
import '../../ui/dialogs/dialog_container.dart';
import '../../ui/widgets/custom_elevated_button.dart';
import '../../ui/widgets/custom_text_field.dart';

class AnswerDialog extends StatefulWidget {
  final Function(String answer) onAnswer;
  final String? answer;
  const AnswerDialog({Key? key, required this.onAnswer, this.answer})
      : super(key: key);

  @override
  State<AnswerDialog> createState() => _AnswerDialogState();
}

class _AnswerDialogState extends State<AnswerDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.answer != null) {
      _textEditingController.text = widget.answer!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      children: [
        CustomTextField(
          customTextFieldModel: CustomTextFieldModel(
            controller: _textEditingController,
            hint: LocaleKeys.user_actions_put_answer.tr(),
            maxLine: 5,
          ),
        ),
        CustomElevatedButton(
          onTap: () {
            Navigator.pop(context);
            if (_textEditingController.text.isNotEmpty) {
              widget.onAnswer(_textEditingController.text);
            }
          },
          buttonColor: context.colorScheme.secondary,
          radius: kRadiusSmall,
          title: LocaleKeys.user_actions_submit.tr(),
        ),
      ],
    );
  }
}

void showAnswerDialog(
  BuildContext context, {
  required Function(String answer) onAnswer,
  String? answer,
}) {
  showDialog(
    context: context,
    builder: (_) => AnswerDialog(
      onAnswer: onAnswer,
      answer: answer,
    ),
  );
}
