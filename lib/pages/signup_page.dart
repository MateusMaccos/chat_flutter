import 'dart:io';
import 'package:flutter/material.dart';
import '../components/user_image_picker.dart';
import '../core/models/auth_form_data.dart';
import 'login_or_signup.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const SignUpPage({required this.onSubmit, super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    _formData.toggleSignUp();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/signup_top.png',
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: size.width * 0.4,
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CADASTRO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    UserImagePicker(
                      onImagePick: _handleImagePick,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    CustomTextField(
                      child: TextFormField(
                        initialValue: _formData.name,
                        onChanged: (name) => _formData.name = name,
                        validator: (_name) {
                          final name = _name ?? '';
                          if (name.trim().length < 5) {
                            return 'Nome deve ter no min 5 caracteres.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "Seu Nome",
                          border: InputBorder.none,
                        ),
                        key: const ValueKey('name'),
                      ),
                    ),
                    CustomTextField(
                      child: TextFormField(
                        key: const ValueKey('email'),
                        initialValue: _formData.email,
                        onChanged: (email) => _formData.email = email,
                        validator: (_email) {
                          final email = _email ?? '';
                          if (!email.contains('@')) {
                            return 'Email informado inválido.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "Seu Email",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    CustomTextField(
                      child: TextFormField(
                        key: const ValueKey('password'),
                        initialValue: _formData.password,
                        onChanged: (password) => _formData.password = password,
                        validator: (_password) {
                          final password = _password ?? '';
                          if (password.length < 6) {
                            return 'Senha deve ter no mínimo 6 caracteres.';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "Senha",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    RoundedButton(
                      size: size,
                      text: 'CADASTRAR',
                      press: _submit,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Já tem uma conta ? ',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => LoginPage(
                                      onSubmit: widget.onSubmit,
                                    )));
                          },
                          child: Text(
                            'Faça Login',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
