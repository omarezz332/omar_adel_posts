import 'package:easy_localization/easy_localization.dart';

extension FieldValidate on String {
  String? validate(List<String? Function(String?)> functions) {
    for (final String? Function(String?) func in functions) {
      final result = func(this);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}

String? validateRequired(String? value) {
  return value!.isEmpty ? tr('validation.required') : null;
}

String? validatePassword(String? value) {
  return value!.length < 5
      ? tr("validation.password_short")
      : value.length < 5
          ? tr("validation.password_long")
          : null;
}

String? matchesPasswords(String value, String value2) {
  return value != value2 ? tr("validation.password_miss_match") : null;
}

//  name
String? minNameLength(String value) {
  return value.length < 3
      ? tr('validation.short', namedArgs: {'value': tr('input_labels.name')})
      : null;
}

String? maxNameLength(
  String value,
) {
  return value.length > 20
      ? tr('validation.long', namedArgs: {'value': tr('input_labels.name')})
      : null;
}

String? minAddressLength(String value) {
  return value.length < 3 ? tr('validation.last_name_short') : null;
}

String? maxAddressLength(
  String value,
) {
  return value.length > 20 ? tr('validation.last_name_long') : null;
}

String? minPostCodeLength(String value) {
  return value.length < 3 ? tr('validation.last_name_short') : null;
}

String? maxPostCodeLength(
  String value,
) {
  if (value.length > 20) {
    return tr('validation.last_name_long');
  } else {
    return null;
  }
}
String? maxPostTextLength(
    String? value,
    ) {
  if (value!.length > 200) {
    return tr('validation.last_name_long');
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  const pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regExp = RegExp(pattern);
  if (!regExp.hasMatch(value!)) {
    return tr('validation.invalid_email');
  }
  return null;
}

