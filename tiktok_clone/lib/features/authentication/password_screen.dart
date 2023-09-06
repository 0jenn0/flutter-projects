import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants/gaps.dart';
import 'package:tiktok_clone/contants/sizes.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  String? _isPasswordValid() {
    if (_password.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_password)) {
      return "Password not valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus(); // foucs된 모든 것들을 unfocus
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PasswordScreen(),
    ));
  }

  void _onSubmit() {
    if (_password.isEmpty || _isPasswordValid() != null) return;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          'Sign up',
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                'Passwordl',
                style: TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w700),
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                autocorrect: false,
                onEditingComplete: _onSubmit,
                decoration: InputDecoration(
                  hintText: "Make it strong",
                  errorText: _isPasswordValid(),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  )),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v16,
              GestureDetector(
                  onTap: _onSubmit,
                  child: FormButton(
                      disabled:
                          _password.isEmpty || _isPasswordValid() != null))
            ],
          ),
        ),
      ),
    );
  }
}
