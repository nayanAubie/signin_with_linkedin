import 'package:http/browser_client.dart';
import 'package:http/http.dart';

/// Http client for web.
Client httpClient() {
  return BrowserClient();
}
