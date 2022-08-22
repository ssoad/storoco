import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:spooky/core/models/sound_model.dart';
import 'package:spooky/theme/m3/m3_color.dart';
import 'package:spooky/utils/constants/config_constant.dart';

class MusicBackgroundImage extends StatelessWidget {
  const MusicBackgroundImage({
    Key? key,
    required this.offsetBuilder,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;
  final Widget Function({
    required Widget Function(double, double, Widget?) builder,
    Widget? child,
  }) offsetBuilder;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    return offsetBuilder(
      child: CachedNetworkImage(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        color: M3Color.of(context).background.withOpacity(0.25),
        colorBlendMode: darkMode ? BlendMode.darken : BlendMode.lighten,
        imageUrl: imageUrl,
      ),
      builder: (offset, effectiveOffset, child) {
        return AnimatedOpacity(
          opacity: min(1, max(0, 1 - effectiveOffset)),
          duration: ConfigConstant.fadeDuration,
          child: Transform.scale(
            scale: max(1, lerpDouble(1.1, 1, effectiveOffset) ?? 0.0),
            child: child,
          ),
        );
      },
    );
  }
}
