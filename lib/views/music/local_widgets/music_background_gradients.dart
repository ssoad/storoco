import 'package:flutter/material.dart';
import 'package:spooky/theme/m3/m3_color.dart';

class MusicBottomGradient extends StatelessWidget {
  const MusicBottomGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height - 250,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              M3Color.of(context).background,
              M3Color.of(context).background.withOpacity(0.9),
              M3Color.of(context).background.withOpacity(0.0),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicTopGradient extends StatelessWidget {
  const MusicTopGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            M3Color.of(context).background,
            M3Color.of(context).background.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}

class MusicUpperBottomGradient extends StatelessWidget {
  const MusicUpperBottomGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: [
                M3Color.of(context).background,
                M3Color.of(context).background.withOpacity(0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
