// ignore_for_file: prefer_const_constructors


import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import 'package:flutter/material.dart';
import 'common_space_divider_widget.dart';
import 'icon_and_image.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final FocusNode? focusNode;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool? autocorrect;
  final FormFieldValidator<String>? validator;
  final bool? readOnly;
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final String? obscuringCharacter;

  const CommonTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.onChanged,
    this.obscuringCharacter,
    this.onTap,
    this.validator,
    this.labelText,
    this.hintText,
    this.prefix,
    this.suffix,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final TextAlign textAlign = TextAlign.start;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.labelText == ''
            ? verticalSpace(0)
            : Text(
                widget.labelText!,
                style: pMedium16.copyWith(color: AppColor.cDarkGreyFont),
              ),
        widget.labelText == ''
            ? verticalSpace(0)
            :  verticalSpace(15),
        Center(
          child: TextFormField(
            controller: widget.controller,
            cursorColor: AppColor.cHintFont,
            autofocus: widget.autofocus ?? false,
            focusNode: _focus,
            readOnly: widget.readOnly ?? false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText ?? false,
            obscuringCharacter: widget.obscuringCharacter ?? ' ',
            keyboardType: widget.keyboardType,
            style: pMedium16.copyWith(),
            decoration: InputDecoration(
              // fillColor:
              //     _focus.hasFocus ? AppColor.cLightBlue : AppColor.cTransparent,
              // filled: true,
              hintText: widget.hintText,
              hintStyle: pMedium14.copyWith(color: AppColor.cDarkGreyFont),
              errorStyle: pMedium12.copyWith(color: AppColor.cRedText),
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix,
              // prefixIconConstraints: BoxConstraints(maxWidth: 55, minWidth: 54),
              suffixIconConstraints: BoxConstraints(maxWidth: 45, minWidth: 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.cRed),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.cBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.themeGreenColor, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
