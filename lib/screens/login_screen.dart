import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthProvider>().enter(_nameController.text);
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      body: AuthLayout(
        title: 'Siapa namamu?',
        subtitle: 'Namamu akan tampil di beranda dan hasil kuis.',
        form: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Nama',
                hint: 'Tulis namamu',
                icon: Icons.person_outline_rounded,
                controller: _nameController,
                validator: Validators.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                autofillHints: const [AutofillHints.name],
              ),
              SizedBox(height: r.sp(24)),
              AppButton(label: 'Mulai belajar', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
