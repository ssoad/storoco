import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

enum RelaxSoundType {
  music,
  rain,
  environment,
}

class RelaxSoundModel {
  final RelaxSoundType type;
  final String title;
  final String? authur;
  final String? backgroundImage;
  final IconData? weatherIcon;
  final String? license;
  final String pathUrl;
  final int? colorDayIndex;
  final String? ref;

  RelaxSoundModel({
    required this.type,
    required this.title,
    required this.pathUrl,
    required this.ref,
    this.colorDayIndex,
    this.authur,
    this.backgroundImage,
    this.weatherIcon,
    this.license,
  });
}

Map<RelaxSoundType, List<RelaxSoundModel>> get relaxSoundsDatas => {
      ///////////
      //  RAIN //
      ///////////
      RelaxSoundType.rain: [
        RelaxSoundModel(
          title: 'Water Stream',
          authur: "LesFM",
          type: RelaxSoundType.environment,
          pathUrl: 'environment/cagancelik__river-stream-subtle-slow-gentle.mp3',
          ref: 'https://www.chosic.com/download-audio/27951',
          colorDayIndex: DateTime.monday,
          license: '''
Music: https://www.chosic.com/free-music/all/ 
''',
        ),
      ],

      ///////////
      //  ENV  //
      ///////////
      RelaxSoundType.environment: [
        RelaxSoundModel(
          title: 'Water Stream',
          type: RelaxSoundType.environment,
          pathUrl: 'environment/cagancelik__river-stream-subtle-slow-gentle.mp3',
          ref: 'https://www.chosic.com/download-audio/27951',
          weatherIcon: WeatherIcons.raindrop,
          colorDayIndex: DateTime.tuesday,
          license: '''
Music: https://www.chosic.com/free-music/all/ 
''',
        ),
        RelaxSoundModel(
          title: 'Ocean Waves',
          type: RelaxSoundType.environment,
          pathUrl: 'environment/nervousneal__morning-surf-at-boracay-philippines.mp3',
          ref: 'https://www.chosic.com/download-audio/27942/',
          weatherIcon: WeatherIcons.flood,
          colorDayIndex: DateTime.thursday,
          license: '''
Music: https://www.chosic.com/free-music/all/
''',
        ),
        RelaxSoundModel(
          title: 'Fire in fireplace',
          type: RelaxSoundType.environment,
          pathUrl: 'environment/Fire-in-fireplace.mp3',
          colorDayIndex: DateTime.monday,
          weatherIcon: WeatherIcons.fire,
          ref: 'https://www.chosic.com/download-audio/29262/',
          license: '''
Music: https://www.chosic.com/free-music/all/
''',
        ),
      ],

      ///////////
      // MUSIC //
      ///////////
      RelaxSoundType.music: [
        RelaxSoundModel(
          title: 'Calm and Peaceful',
          type: RelaxSoundType.music,
          pathUrl: 'music/Calm-and-Peaceful.mp3',
          ref: 'https://www.chosic.com/download-audio/29589/',
          backgroundImage:
              'https://res.cloudinary.com/juniorise/image/upload/v1647890323/william-zhang-4KKVELjJsNw-unsplash_1-min_xgid9c.jpg',
          license: '''
Calm and Peaceful by LesFM | https://lesfm.net/relaxing-background-music/
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY 3.0
https://creativecommons.org/licenses/by/3.0/
''',
        ),
        RelaxSoundModel(
          title: 'Guitar Gentle',
          authur: "PeriTune",
          type: RelaxSoundType.music,
          pathUrl: 'music/Guitar-Gentle.mp3',
          ref: 'https://www.chosic.com/download-audio/29514/',
          backgroundImage:
              'https://res.cloudinary.com/juniorise/image/upload/v1647885863/christian-spuller-Oaec-W0b2ss-unsplash-min_icm1o9.jpg',
          license: '''
Guitar Gentle by PeriTune | https://peritune.com/
Music promoted by https://www.chosic.com/free-music/all/
Creative Commons CC BY 4.0
https://creativecommons.org/licenses/by/4.0/
''',
        ),
        RelaxSoundModel(
          title: 'Happy Clappy',
          authur: "John Bartmann",
          type: RelaxSoundType.music,
          pathUrl: 'music/John_Bartmann_-_09_-_Happy_Clappy-1.mp3',
          ref: 'https://www.chosic.com/download-audio/24390/',
          backgroundImage:
              'https://res.cloudinary.com/juniorise/image/upload/v1647885913/simon-berger-EPgGW0EMshY-unsplash-min_vbozsx.jpg',
          license: '''
Music: https://www.chosic.com/free-music/all/
''',
        ),
        RelaxSoundModel(
          title: 'Spatium',
          authur: "Keys of Moon",
          type: RelaxSoundType.music,
          pathUrl: 'music/Spatium-Calm-Ambient-Music.mp3',
          ref: 'https://www.chosic.com/download-audio/28307/',
          backgroundImage:
              'https://res.cloudinary.com/juniorise/image/upload/v1647890539/les-argonautes-iecFSEsQiqY-unsplash_1-min_mx8xu9.jpg',
          license: '''
Spatium by Keys of Moon | https://soundcloud.com/keysofmoon
Music promoted by https://www.chosic.com/free-music/all/
Attribution 4.0 International (CC BY 4.0)
https://creativecommons.org/licenses/by/4.0/

''',
        ),
        RelaxSoundModel(
          title: 'The Inspiration',
          authur: "Keys of Moon",
          type: RelaxSoundType.music,
          pathUrl: 'music/The-Inspiration-mp3.mp3',
          ref: 'https://www.chosic.com/download-audio/27962/',
          backgroundImage:
              'https://res.cloudinary.com/juniorise/image/upload/v1647886602/sean-mcauliffe-2QS7wbeRe3c-unsplash-min_1_n3tl10.jpg',
          license: '''
The Inspiration by Keys of Moon | https://soundcloud.com/keysofmoon
Attribution 4.0 International (CC BY 4.0)
https://creativecommons.org/licenses/by/4.0/
Music promoted by https://www.chosic.com/free-music/all/
''',
        ),
      ],
    };
