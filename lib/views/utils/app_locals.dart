import 'package:flutter_localization/flutter_localization.dart';

mixin AppLocale {
  static const String title = 'title';
  static const String mz = 'maza';
  static const String home = 'Home';
  static const String quotesApp = 'Quotes App';
  static const String dailyQuotes = 'Daily Quotes';
  static const String favourites = 'Favourites';
  static const String favouritesQuotes = 'Favourites Quotes';
  static const String quoteOfTheDay = 'Quote Of The Day';
  static const String iAgreeToThe = 'I agree to the';
  static const String forgetPassword = 'Forget Password';
  static const String recoverYourPassword = 'Recover Your Password';
  static const String rememberYourPassword = 'Remember your password? Login';
  static const String login = 'Login';
  static const String signUp = 'Sign Up';
  static const String signOut = 'Sign Out';
  static const String loginInstead = 'Login Instead';
  static const String signUpInstead = 'Sign Up Instead';
  static const String goodToSeeYouBack = 'Good to see you back!';

  static const String password = 'Password';
  static const String termsAndContion = 'Terms and Conditions';

  static const String profile = 'Profile';
  static const String changeCategory = 'Change Category';

  final FlutterLocalization localization = FlutterLocalization.instance;

  static const Map<String, dynamic> EN = {
    mz: 'mezzo',
    title: 'Localization',
    quotesApp: 'Quotes App',
    dailyQuotes: 'Daily Quotes',
    favourites: 'Favourites',
    recoverYourPassword: 'Recover Your Password',
    loginInstead: 'Login Instead',
    changeCategory: 'Change Category',
    rememberYourPassword: 'Remember your password? Login',
    favouritesQuotes: 'Favourites Quotes',
    goodToSeeYouBack: "Good to see you back!",
    signUpInstead: "Sign Up Instead",
    quoteOfTheDay: 'Quote Of The Day',
    iAgreeToThe: 'I agree to the',
    forgetPassword: 'Forget Password',
    login: 'Login',
    home: 'Home',
    signUp: 'Sign Up',
    signOut: 'Sign Out',
    password: 'Password',
    termsAndContion: 'Terms and Conditions',
    profile: 'Profile',
  };
  static const Map<String, dynamic> KM = {
    mz: 'mezzo',
    title: 'ការធ្វើមូលដ្ឋានីយកម្ម'
  };

  static const Map<String, dynamic> EB = {
    title: 'ローカリゼーション',
    mz: 'mezzo',
    quotesApp: 'Tsitaatide rakendus',
    favouritesQuotes: 'Lemmik Tsitaat',
    dailyQuotes: 'Tsitaat',
    favourites: 'Lemmikud',
    changeCategory: 'Muuda kategooriat',
    loginInstead: 'Selle asemel sisse logida?',
    goodToSeeYouBack: 'Tore teid tagasi näha!',
    signOut: 'Logi välja',
    rememberYourPassword: 'Kas mäletasite oma parooli? Logi sisse',
    recoverYourPassword: 'Taasta oma parool',
    signUpInstead: 'Selle asemel registreeruda?',
    quoteOfTheDay: 'Tsitaat päeval',
    iAgreeToThe: 'Nõustun kõigi ',
    forgetPassword: 'Unustasid parooli',
    password: 'Parool',
    signUp: 'Registreeri',
    login: 'Logi sisse',
    profile: 'Profiil',
    termsAndContion: 'tingimustega',
    home: 'Kodu',
  };
}
