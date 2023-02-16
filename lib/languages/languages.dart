import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  static final defaultt = Locale("tr", "TR");

  static final languages = [Locale("tr", "TR"), Locale("en", "US")];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'sifre_girin': "Password",
          'forget': 'Forget Password',
          'register': 'Register',
          'Giris': 'Sign in ',
          'welcome': 'Welcome back you\'ve been missed!',
          'Kayit': 'Register and join us!',
          'TekrarGir': 'Confirm Password',
          'Information':
              'This application also contains information about historical places in Turkey, along with their location. There are 144 historical places with their locations. You can search and find the desired historical place with the name of the place on the phone with Google Maps or the Map application',
          'Welcome2': 'Welcome!',
          'Start': 'Start',
          'member': 'Not a member?',
          'register_now': 'Register now',
          'Hello': 'HELLO AGAIN'
          
        },
        'tr_TR': {
          'sifre_girin': "Şifrenizi Girin",
          'forget': "Şifremi unuttum",
          'register': 'Kayıt Ol',
          'Giris': 'Giriş Yapınız',
          'welcome': 'Tekrar hoşgeldiniz',
          'Kayit': 'Kayıt olun ve bize katılın!',
          'TekrarGir': 'Şifrenizi Onaylayın',
          'Information':
              'Bu uygulama da Türkiyedeki tarihi yerlerin, konumuyla beraber ulaşabileceğiniz bilgiler bulunmaktadır. 144 tane tarihi yerlerin konumuyla, yerleri mevcuttur. İstenilen tarihi yerin ismiyle birlikte telefondan Google Maps veya Harita uygulamasıyla beraber aratıp bulabilirsiniz.',
          'Welcome2': 'Hoşgeldiniz!',
          'Start': 'Başla',
          'member': 'Üye değil misin?',
          'register_now': 'Şimdi üye ol',
          'Hello': 'TEKRAR HOŞGELDİN'
        }
      };


}
