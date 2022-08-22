import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:spooky/core/base/base_view_model.dart';
import 'package:spooky/core/models/relax_sound_model.dart';
import 'package:spooky/core/models/sound_model.dart';
import 'package:spooky/core/services/loop_audio_seamlessly.dart';

class MusicViewModel extends BaseViewModel {
  late final ScrollController scrollController;
  late final ValueNotifier<double> offsetNotifier;

  final player = LoopAudioSeamlessly((state) {});

  Set<String> playingMusics = {};
  void play(RelaxSoundModel sound) {
    if (playingMusics.contains(sound.pathUrl)) {
      playingMusics.remove(sound.pathUrl);
      player.pause();
    } else {
      playingMusics.add(sound.pathUrl);
      player.playAsset(sound.pathUrl);
    }
    notifyListeners();
  }

  bool playing(RelaxSoundModel sound) {
    return playingMusics.contains(sound.pathUrl);
  }

  String imageUrl() {
    final images = relaxSoundsDatas[RelaxSoundType.music]?.where((element) => playingMusics.contains(element.pathUrl));
    final fallbackImage = SoundModel.weatherImage(WeatherType.lightSnow).url;
    if (images?.isNotEmpty == true) {
      return images!.last.backgroundImage ?? fallbackImage;
    } else {
      return fallbackImage;
    }
  }

  MusicViewModel() {
    scrollController = ScrollController();
    offsetNotifier = ValueNotifier(0.0);

    scrollController.addListener(() {
      offsetNotifier.value = scrollController.offset;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    offsetNotifier.dispose();
    player.dispose();
    super.dispose();
  }
}
