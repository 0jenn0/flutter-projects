import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants/gaps.dart';
import 'package:tiktok_clone/contants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose(); // 얘는 뒤에 두자.
  }

  void _onNextTap() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const EmailScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Sign Up",
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When's your birthday?",
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w700),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _birthdayController,
              decoration: InputDecoration(
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
                onTap: _onNextTap, child: const FormButton(disabled: false))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            height: 300,
            child: CupertinoDatePicker(
              maximumDate: initialDate,
              initialDateTime: initialDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: _setTextFieldDate,
            )),
      ),
    );
  }
}
