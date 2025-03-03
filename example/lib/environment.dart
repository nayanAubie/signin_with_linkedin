/// Class that helps easy access to the environment variables.
final class Environment {
  Environment._();

  static const clientId = String.fromEnvironment('CLIENT_ID');
  static const clientSecret = String.fromEnvironment('CLIENT_SECRET');
  static const redirectUrl = String.fromEnvironment('REDIRECT_URL');
}
