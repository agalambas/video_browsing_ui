import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/config/theme.dart';
import 'package:video_browsing_ui/pages/overview_page.dart';

class LoginPage extends StatefulWidget {
  static const route = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: screenHeight(context),
              padding: const EdgeInsets.all(kSpace * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kSpace * 2),
                  Center(
                    child: SvgPicture.asset(
                      'assets/blindside_horizontal_logo.svg',
                      color: theme.colorScheme.onBackground,
                      height: 18,
                    ),
                  ),
                  // const Spacer(),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   children: [
                  //     SvgPicture.asset(
                  //       'assets/blindside_logo.svg',
                  //       color: theme.colorScheme.onBackground,
                  //       height: 48,
                  //     ),
                  //     const SizedBox(height: kSpace),
                  //     SvgPicture.asset(
                  //       'assets/blindside_title.svg',
                  //       color: theme.colorScheme.onBackground,
                  //       height: 16,
                  //     ),
                  //   ],
                  // ),
                  const Spacer(flex: 2),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: theme.textTheme.titleMedium,
                    decoration: customInputDecoration(
                      label: 'Email',
                      hint: 'yourname@example.com',
                    ),
                  ),
                  const SizedBox(height: kSpace * 2),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: !showPassword,
                    style: theme.textTheme.titleMedium,
                    decoration: customInputDecoration(
                      label: 'Password',
                      hint: 'yourpassword',
                    ).copyWith(
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => showPassword = !showPassword),
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18,
                          color: Palette.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kSpace * 6),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(screenWidth(context), 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, OverviewPage.route), //TODO login
                    child: const Text('Login'),
                  ),
                  const Spacer(),
                  Text(
                    'Don\'t have an account yet?',
                    style: theme.textTheme.titleSmall!
                        .copyWith(color: Palette.grey),
                  ),
                  const SizedBox(height: kSpace),
                  Text(
                    'Sign Up',
                    style: theme.textTheme.titleSmall,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
