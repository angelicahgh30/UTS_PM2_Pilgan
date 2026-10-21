import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;

  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.icon,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onSubmitted,
    this.autofillHints,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: r.text(context.texts.titleSmall)),
        SizedBox(height: r.sp(8)),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          onFieldSubmitted: widget.onSubmitted,
          autofillHints: widget.autofillHints,
          style: r.text(context.texts.bodyLarge),
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: EdgeInsets.symmetric(
              horizontal: r.sp(16),
              vertical: r.sp(16),
            ),
            prefixIcon: widget.icon == null
                ? null
                : Icon(widget.icon, size: r.sp(20)),
            suffixIcon: widget.isPassword
                ? IconButton(
                    tooltip: _obscure ? 'Tampilkan' : 'Sembunyikan',
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: r.sp(20),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
