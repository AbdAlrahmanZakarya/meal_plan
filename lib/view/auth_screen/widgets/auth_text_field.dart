import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/colors.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final String? hint;
  final String? prefixIcon;
  final bool isPasswordField;
  final Widget? suffixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.isPasswordField = false,
    this.suffixIcon,
    this.readOnly = false,
    this.controller,
    this.onTap,
    this.style,
    this.validator,
    this.keyboardType,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onTap: widget.onTap,
      controller: widget.controller,

      readOnly: widget.readOnly,
      obscureText: widget.isPasswordField && obscureText,
      autocorrect: false,
      style: widget.style ??
          Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black,
              ),
      decoration: InputDecoration(
        errorMaxLines: 3,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Container(
                alignment: Alignment.center,
                height: 16,
                width: 18,
                child: SvgPicture.asset(
                  widget.prefixIcon!,
                ),
              ),
        hintText: widget.hint,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: SvgPicture.asset(
                  obscureText
                      ? 'assets/icons/visible.svg'
                      : 'assets/icons/unvisible.svg',
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
