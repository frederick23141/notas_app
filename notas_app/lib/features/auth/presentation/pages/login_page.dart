import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_app/core/constants/app_texts.dart';
import 'package:notas_app/core/routes/app_routes.dart';
import 'package:notas_app/core/themes/app_themes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:notas_app/core/constants/app_images.dart';
import 'package:notas_app/core/constants/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  //metodo para determinar se se clickeo el mostrar contrase;a
  bool isPasswordShown = false;
  onPawssShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.defaultInputDecorationTheme,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppTexts.titleLogin)),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushNamed(context, AppRoutes.home);
              // Navigator.pushReplacementNamed(context, '/home');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(60),
                    child: Image.asset(AppImages.logo),
                  ),
                  //Email Field
                  TextFormField(
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: AppTexts.hintTextEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return AppTexts.fieldNullEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  //Pasword Field
                  TextFormField(
                    controller: passCtrl,
                    //decoration: const InputDecoration(labelText: "Contraseña"),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      //suffixIcon: Icon(Icons.visibility_outlined),
                      suffixIcon: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: onPawssShowClicked,
                          icon: Icon(Icons.visibility_outlined),
                        ),
                      ),
                      hintText: AppTexts.hintTextPassword,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    //obscureText: true,
                    obscureText: !isPasswordShown,
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return AppTexts.fieldNullPassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      minimumSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          LoginRequested(emailCtrl.text, passCtrl.text),
                        );
                      }
                    },
                    child: const Text(
                      AppTexts.btnTextLogin,
                      style: TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
