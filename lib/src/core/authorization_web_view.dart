import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView to handle authorization/logout flows.
class AuthorizationWebView extends StatefulWidget {
  final Uri initialUri;
  final Uri redirectUri;
  final String? title;
  final PreferredSizeWidget? appBar;

  const AuthorizationWebView({
    super.key,
    required this.initialUri,
    required this.redirectUri,
    required this.title,
    required this.appBar,
  });

  @override
  State<AuthorizationWebView> createState() => _AuthorizationWebViewState();
}

class _AuthorizationWebViewState extends State<AuthorizationWebView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.transparent)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) async {
                final isRedirect = request.url.startsWith(
                  widget.redirectUri.toString(),
                );
                if (isRedirect) {
                  Navigator.of(context).pop(request.url);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(widget.initialUri);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.appBar != null || widget.title != null,
      'Either appBar or title must be provided',
    );
    return Scaffold(
      appBar: widget.appBar ?? AppBar(title: Text(widget.title!)),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
