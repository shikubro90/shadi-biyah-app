import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_icons.dart';
import 'package:matrimony/view/widget/custom_img/custom_img.dart';

class CustomTextField extends StatefulWidget {
  static void _defaultOnTap() {}
  const CustomTextField({
    this.textEditingController,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = AppColors.black20,
    this.inputTextStyle,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.fillColor = AppColors.white100,
    this.suffixIcon,
    this.onChanged,
    this.suffixIconColor,
    this.fieldBorderRadius = 8,
    this.fieldBorderColor = AppColors.black10,
    this.isPassword = false,
    this.readOnly = true,
    super.key,
    this.onTapClick = _defaultOnTap,
    this.isPrefixIcon = false,
    this.focusBorderColor = AppColors.black40,
  });

  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;

  final FormFieldValidator? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final double fieldBorderRadius;
  final Color fieldBorderColor;
  final Color focusBorderColor;
  final void Function(String)? onChanged;
  final bool isPassword;
  final bool isPrefixIcon;
  final VoidCallback onTapClick;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        widget.onTapClick();
      },
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: widget.readOnly,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      cursorColor: widget.cursorColor,
      style: widget.inputTextStyle,
      maxLines: widget.maxLines,
      obscureText: widget.isPassword ? obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.black40),
        fillColor: widget.fillColor,
        filled: true,
        prefixIcon: widget.isPrefixIcon
            ? const Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 16, vertical: 14),
                child: CustomImage(
                  imageSrc: AppIcons.search,
                  imageColor: AppColors.black80,
                ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: toggle,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16, vertical: 14),
                  child: obscureText
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: AppColors.black20,
                        )
                      : const Icon(Icons.visibility_outlined,
                          color: AppColors.black20),
                ))
            : widget.suffixIcon,
        suffixIconColor: widget.suffixIconColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            gapPadding: 0),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.focusBorderColor, width: 1),
            gapPadding: 0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            gapPadding: 0),
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
