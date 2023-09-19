import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../signin_with_linkedin.dart';

typedef OnGetAuthToken = void Function(LinkedInAccessToken data);
typedef OnGetUserProfile = void Function(LinkedInUser user);
typedef OnSignInError = void Function(LinkedInError error);

class LinkedInWebViewPage extends StatefulWidget {
  final bool getUserProfile;
  final PreferredSizeWidget? appBar;

  const LinkedInWebViewPage({
    super.key,
    required this.getUserProfile,
    this.appBar,
  });

  @override
  State<LinkedInWebViewPage> createState() => _LinkedInWebViewPageState();
}

class _LinkedInWebViewPageState extends State<LinkedInWebViewPage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) async {
            final isRedirect =
                request.url.startsWith(ApiService.instance.config.redirectUrl);
            if (isRedirect) {
              authorizeUser(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(ApiService.instance.config.authorizationUrl));
  }

  Future<void> authorizeUser(String url) async {
    try {
      final authCode = url.split('?').last.split('&').first.split('=').last;
      final accessTokenData =
          await ApiService.instance.getAccessToken(code: authCode);
      if (!widget.getUserProfile && mounted) {
        Navigator.of(context).pop(accessTokenData);
        return;
      }
      if (accessTokenData.tokenType != null &&
          accessTokenData.accessToken != null) {
        final userInfo = await ApiService.instance.getUserInfo(
          tokenType: accessTokenData.tokenType!,
          token: accessTokenData.accessToken!,
        );
        if (mounted) Navigator.of(context).pop(userInfo);
      }
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      if (mounted) {
        Navigator.of(context)
            .pop(e is LinkedInError ? e : LinkedInError(message: e.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ??
          AppBar(
            title: const Text('Sign in with LinkedIn'),
          ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
