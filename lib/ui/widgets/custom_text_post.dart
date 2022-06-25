import 'package:flutter/material.dart';
import '../../helpers/extensions.dart';
import '../../helpers/sized_boxes.dart';
import '../../theme/dimensions.dart';

class CustomTextPost extends StatefulWidget {
  final CustomTextFieldModel customTextFieldModel;

  const CustomTextPost({Key? key, required this.customTextFieldModel})
      : super(key: key);

  @override
  State<CustomTextPost> createState() => _CustomTextPostState();
}

class _CustomTextPostState extends State<CustomTextPost> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.customTextFieldModel.label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                widget.customTextFieldModel.label,
                style: widget.customTextFieldModel.labelStyle ??
                    context.textTheme.button!.copyWith(
                      color: context.theme.disabledColor.withOpacity(0.6),
                      fontFamily: 'segoe',
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
          kVerticalSizedBoxXXSmall,
          TextFormField(
            enabled: widget.customTextFieldModel.enabled,
            style: context.textTheme.headline5,
            controller: widget.customTextFieldModel.controller,
            initialValue: widget.customTextFieldModel.controller == null
                ? widget.customTextFieldModel.initialValue
                : null,
            onChanged: widget.customTextFieldModel.onChange,
            enableSuggestions: widget.customTextFieldModel.enableSuggestions,
            obscureText:
                !widget.customTextFieldModel.isPassword ? false : obscure,
            keyboardType: widget.customTextFieldModel.textInputType,
            validator: widget.customTextFieldModel.validator,
            maxLines: widget.customTextFieldModel.maxLine,
            onSaved: widget.customTextFieldModel.onSave,
            decoration: InputDecoration(
              contentPadding: widget.customTextFieldModel.borderInIcon
                  ? const EdgeInsets.symmetric(vertical: 12, horizontal: 4)
                  : const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              border: widget.customTextFieldModel.borderInIcon
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall),
                      borderSide: BorderSide(color: context.theme.hoverColor),
                    ),
              focusedBorder: widget.customTextFieldModel.borderInIcon
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall),
                      borderSide: BorderSide(color: context.theme.hoverColor),
                    ),
              enabledBorder: widget.customTextFieldModel.borderInIcon
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall),
                      borderSide: BorderSide(color: context.theme.hoverColor),
                    ),
              disabledBorder: widget.customTextFieldModel.borderInIcon
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall),
                      borderSide: BorderSide(color: context.theme.hoverColor),
                    ),
              suffixIcon: widget.customTextFieldModel.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(
                        !obscure ? Icons.visibility_off : Icons.visibility,
                        color: context.theme.dividerColor,
                      ),
                    )
                  : widget.customTextFieldModel.isSearch
                      ? const Icon(Icons.search)
                      : widget.customTextFieldModel.suffixIcon,
              prefixIcon: widget.customTextFieldModel.borderInIcon
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: widget.customTextFieldModel.prefixIcon,
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: context.theme.dividerColor,
                        ) // border beside icon
                      ],
                    )
                  : widget.customTextFieldModel.prefixIcon,
              hintText: widget.customTextFieldModel.hint,
              hintStyle: context.textTheme.button!.copyWith(
                color: context.theme.shadowColor,
                fontFamily: 'segoe',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFieldModel {
  final String label;
  final String hint;
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
  final int maxLine;
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
  });
}
