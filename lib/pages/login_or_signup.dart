import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_chat/pages/signup_page.dart';

import '../core/models/auth_form_data.dart';
import '../core/services/auth/auth_service.dart';
import 'login_page.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  bool _isLoading = false;
  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() {
        _isLoading = true;
      });
      if (formData.isLogin) {
        await AuthService().login(
          formData.email,
          formData.password,
        );
      } else {
        await AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
      //tratar erro
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_top.png',
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/main_bottom.png',
                width: size.width * 0.2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bem vindo ao',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SvgPicture.asset(
                  'assets/icons/inicio.svg',
                  height: size.height * 0.45,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedButton(
                  size: size,
                  text: 'LOGIN',
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => LoginPage(
                              onSubmit: _handleSubmit,
                            )));
                  },
                ),
                RoundedButton(
                  size: size,
                  text: 'REGISTRAR',
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SignUpPage(
                              onSubmit: _handleSubmit,
                            )));
                  },
                  color: Theme.of(context).primaryColor.withAlpha(70),
                  textColor: Colors.black,
                ),
              ],
            ),
            if (_isLoading)
              Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Size size;
  final Function() press;
  final Color? color, textColor;
  const RoundedButton({
    super.key,
    required this.size,
    required this.text,
    required this.press,
    this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: SizedBox(
        height: size.height * 0.08,
        width: size.width * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    color ?? Theme.of(context).primaryColor)),
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
