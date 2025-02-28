import 'package:flutter/material.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';

import '../widgets/dialog/confirmation_dialog.dart';
import '../widgets/dialog/info_dialog.dart';
import '../widgets/token_info_widget.dart';
import '../widgets/user_info_widget.dart';

class HomeScreen extends StatefulWidget {
  final SignInWithLinkedIn linkedin;
  final String authCode;

  const HomeScreen({super.key, required this.authCode, required this.linkedin});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LinkedInTokenInfo? _tokenInfo;
  LinkedInUser? _user;

  @override
  void initState() {
    super.initState();
    try {
      _getAuthTokenInfo();
    } catch (e) {
      showInfoDialog(
        context: context,
        title: 'Exception',
        content: e.toString(),
      );
    }
  }

  Future<void> _getAuthTokenInfo() async {
    final (tokenInfo, error) = await widget.linkedin.getAccessToken(
      authorizationCode: widget.authCode,
    );
    if (tokenInfo != null) {
      setState(() => _tokenInfo = tokenInfo);
      _getUserInfo();
    } else {
      showInfoDialog(
        context: context,
        title: 'Error in getting token info',
        content: error?.toJson().toString() ?? 'Unknown error',
      );
    }
  }

  Future<void> _getUserInfo() async {
    final (user, error) = await widget.linkedin.getUserInfo(
      tokenInfo: _tokenInfo!,
    );
    if (user != null) {
      setState(() => _user = user);
    } else {
      showInfoDialog(
        context: context,
        title: 'Error in getting user info',
        content: error?.toJson().toString() ?? 'Unknown error',
      );
    }
  }

  Future<bool> _logout() async {
    return widget.linkedin.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LinkedIn Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final result = await showConfirmationDialog(
                context: context,
                title: 'Logout',
                content: 'Are you sure to want to logout?',
              );
              if (result ?? false) {
                final success = await _logout();
                if (success && context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      ),
      body:
          _tokenInfo != null
              ? ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  TokenInfoWidget(tokenInfo: _tokenInfo!),
                  const SizedBox(height: 24),
                  if (_user != null)
                    UserInfoWidget(user: _user!)
                  else
                    const Center(child: CircularProgressIndicator()),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
