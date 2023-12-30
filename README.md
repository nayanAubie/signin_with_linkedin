A Flutter package that helps to <b>Sign in with LinkedIn</b>

It also supports `Flutter Web`.

## Overview

- This package uses the `v2` flow of Sign in - [Sign In with LinkedIn using OpenID Connect]
- The old flow of [Sign In with LinkedIn] has been deprecated.

## Getting started

- You must have one LinkedIn account with company page. Company page is required to create and verify your app.
  - [Create your company page] if you don't have.
- Login to the [LinkedIn Developer] to create an app.

## Create an app on LinkedIn
- Go to the [My Apps] and click on <b>Create app</b>.
- You need to verify the created app by tap on verification link by login to the company account of LinkedIn.
- After that, refresh the `Settings` tab. you should see `Verified` with the date in App Settings.
- Inside the `Auth` tab, set the `Authorized redirect URL` for the app.
  - Generally, it can be your own website or you can use any other website as well.
- Inside the `Products` tab, `Request access` for `Sign In with LinkedIn using OpenID Connect`

## Usage

- Replace the below values

```dart
// Modify the "scope" below as per your need
  final _linkedInConfig = LinkedInConfig(
    clientId: '<<CLIENT ID>>',
    clientSecret: '<<CLIENT SECRET>>',
    redirectUrl: '<<REDIRECT URL>>',
    scope: ['openid', 'profile', 'email'],
  );
```

- Call the `signIn` method.
- `onGetUserProfile` is required to get user profile data.
- Set `onGetAuthToken` callback if you want to use access token related data.
  
```dart
SignInWithLinkedIn.signIn(
    context,
    config: _linkedInConfig,
    onGetAuthToken: (data) {
        log('Auth token data: ${data.toJson()}');
    },
    onGetUserProfile: (user) {
        log('LinkedIn User: ${user.toJson()}');
    },
    onSignInError: (error) {
        log('Error on sign in: $error');
    },
);
```

- Logout from the account

```dart
await SignInWithLinkedIn.logout();
```

## Usage on Flutter Web

- Create a file [`signin_linkedin.html`] in your website's root folder and deploy it on server. It is required to make a callback to dart code after complete the login with LinkedIn on web.
- Add another redirect URL like : `https://your-website/signin_linkedin.html`

## Sign in button

- We've not provided any `button/widget` for `Sign in with LinkedIn`. You can create your own UI for the sign in button.
- You can download button image from LinkedIn [Image Resources]

---

[Sign In with LinkedIn using OpenID Connect]: https://learn.microsoft.com/en-us/linkedin/consumer/integrations/self-serve/sign-in-with-linkedin-v2
[Sign In with LinkedIn]: https://learn.microsoft.com/en-us/linkedin/consumer/integrations/self-serve/sign-in-with-linkedin
[LinkedIn Developer]: https://developer.linkedin.com/
[Create your company page]: https://www.linkedin.com/company/setup/new/
[My Apps]: https://www.linkedin.com/developers/apps
[Image Resources]: https://learn.microsoft.com/en-us/linkedin/consumer/integrations/self-serve/sign-in-with-linkedin-v2#image-resources

[`signin_linkedin.html`]: example/web/signin_linkedin.html
