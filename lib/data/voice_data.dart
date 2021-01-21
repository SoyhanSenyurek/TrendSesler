import 'package:deneme_f/data/voice.dart';

class VoiceData {
  static List<Voice> getVoice() {
    return [
      new Voice(1, "Alkış Sesi", "alkissesi.mp3",
          "https://image.shutterstock.com/image-vector/applause-icon-600w-670666489.jpg"),
      new Voice(2, "Akasya Durağı Şaşırma sesi", "akasya.mp3",
          "https://i.ytimg.com/vi/LK7Avy9OEVI/hqdefault.jpg")
    ];
  }
}
