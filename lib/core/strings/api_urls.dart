class ApiUrls {
  // * Firebase Urls
  static const String _projectKey = 'AIzaSyA4_bbIvPJoW15sXKcTwq2Q9AnfRCIdcQY';
  static const String _authBaseUrl =
      'https://identitytoolkit.googleapis.com/v1/';
  static const String signUpUrl =
      '${_authBaseUrl}accounts:signUp?key=$_projectKey';
  static const String signInUrl =
      '${_authBaseUrl}accounts:signInWithPassword?key=$_projectKey';
  static const String sendResetCodeUrl =
      '${_authBaseUrl}accounts:sendOobCode?key=$_projectKey';

}

