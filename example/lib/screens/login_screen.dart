import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';

import '../widgets/dialog/info_dialog.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Modify the "scope" below as per your need
  final _linkedInConfig = LinkedInConfig(
    clientId: '<<CLIENT ID>>',
    clientSecret: '<<CLIENT SECRET>>',
    redirectUrl: '<<REDIRECT URL>>',
    scope: ['openid', 'profile', 'email'],
  );

  late final linkedin = SignInWithLinkedIn(config: _linkedInConfig);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final (authCode, error) = await linkedin.getAuthorizationCode(
              context: context,
            );

            if (authCode != null) {
              if (!kIsWeb) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            HomeScreen(authCode: authCode, linkedin: linkedin),
                  ),
                );
              } else {
                showInfoDialog(
                  context: context,
                  title: 'Platform - Web',
                  content:
                      'Due to CORS restriction, Web is not allowed to perform LinkedIn HTTP requests. check the documentation for more info.',
                );
              }
            } else {
              showInfoDialog(
                context: context,
                title: error?.errorCode ?? 'Error',
                content: error?.errorDescription ?? 'Unknown error',
              );
            }
          },
          child: const Text('SignIn with LinkedIn'),
        ),
      ),
    );
  }
}
