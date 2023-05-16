import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_chat/pages/login_or_signup.dart';
import '../core/models/auth_form_data.dart';

class LoginPage extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const LoginPage({required this.onSubmit, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();
  bool _enableObscure = true;

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
    _formData.toggleSignIn();
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
                'assets/images/main_top.png',
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
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SvgPicture.asset(
                      'assets/icons/login.svg',
                      height: size.height * 0.35,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
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
                      child: Stack(
                        children: [
                          TextFormField(
                            key: const ValueKey('password'),
                            initialValue: _formData.password,
                            onChanged: (password) =>
                                _formData.password = password,
                            validator: (_password) {
                              final password = _password ?? '';
                              if (password.length < 6) {
                                return 'Senha deve ter no mínimo 6 caracteres.';
                              }
                              return null;
                            },
                            obscureText: _enableObscure,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Senha",
                              border: InputBorder.none,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 1,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _enableObscure = !_enableObscure;
                                });
                              },
                              icon: const Icon(Icons.visibility),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      size: size,
                      text: 'LOGIN',
                      press: _submit,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não tem uma conta ? ',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cadastre-se',
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
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Widget child;
  const CustomTextField({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(50),
          borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
