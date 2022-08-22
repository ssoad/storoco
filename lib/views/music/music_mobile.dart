part of music_view;

class _MusicMobile extends StatelessWidget {
  final MusicViewModel viewModel;
  const _MusicMobile(this.viewModel);

  Widget offsetBuilder({
    required Widget Function(double offset, double effectiveOffset, Widget? child) builder,
    Widget? child,
  }) {
    return ValueListenableBuilder<double>(
      valueListenable: viewModel.offsetNotifier,
      child: child,
      builder: (context, offset, child) {
        double effectiveOffset = min(offset, 200) / 200;
        return builder(offset, effectiveOffset, child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          MusicBackgroundImage(
            offsetBuilder: offsetBuilder,
            imageUrl: viewModel.imageUrl(),
          ),
          const MusicTopGradient(),
          const MusicBottomGradient(),
          buildBody(context),
          const MusicUpperBottomGradient(),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return CustomScrollView(
      controller: viewModel.scrollController,
      slivers: [
        buildAppBar(context),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ConfigConstant.sizedBoxH2,
              buildQuote(context),
              ConfigConstant.sizedBoxH2,
              ...SpSectionsTiles.divide(
                context: context,
                showSectionDivider: false,
                sections: relaxSoundsDatas.entries.map((e) {
                  final type = e.key;
                  final sounds = e.value;
                  if (type == RelaxSoundType.music) {
                    return buildMusicSection(
                      context,
                      sounds,
                    );
                  } else {
                    return buildSoundSection(
                      type.name.capitalize,
                      sounds,
                      context,
                    );
                  }
                }).toList(),
              ),
              const SizedBox(height: kToolbarHeight),
            ],
          ),
        ),
      ],
    );
  }

  SliverAppBar buildAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: ModalRoute.of(context)?.canPop == true
          ? const SpPopButton()
          : SpIconButton(
              icon: const Icon(Icons.branding_watermark),
              onPressed: () {},
            ),
      systemOverlayStyle:
          Theme.of(context).brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      // title: offsetBuilder(
      //   child: Text(
      //     "Good afternoon!",
      //     style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(color: M3Color.of(context).onBackground),
      //   ),
      //   builder: (offset, effectiveOffset, child) {
      //     return AnimatedOpacity(
      //       opacity: effectiveOffset > 0.25 ? 0 : 1,
      //       duration: ConfigConstant.fadeDuration,
      //       child: Container(
      //         child: child,
      //       ),
      //     );
      //   },
      // ),
      actions: [
        SpDeveloperVisibility(
          child: SpThemeSwitcher(backgroundColor: Colors.transparent),
        ),
        SpIconButton(
          icon: const Icon(Icons.pause),
          onPressed: () {},
        ),
      ],
    );
  }

  SpSectionContents buildMusicSection(
    BuildContext context,
    List<RelaxSoundModel> sounds,
  ) {
    return SpSectionContents(
      headline: sounds.first.type.name.capitalize,
      // headlineColor: M3Color.of(context).onBackground,
      tiles: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: List.generate(sounds.length, (index) {
              RelaxSoundModel music = sounds[index];
              bool playing = viewModel.playing(music);
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor, width: 1),
                  borderRadius: ConfigConstant.circlarRadius1,
                ),
                child: ListTile(
                  tileColor: Colors.transparent,
                  leading: CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            music.backgroundImage ?? SoundModel.weatherImage(WeatherType.foggy).url,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(music.title),
                  subtitle: Text(music.authur ?? tr("msg.unknown")),
                  shape: RoundedRectangleBorder(borderRadius: ConfigConstant.circlarRadius1),
                  trailing: SpAnimatedIcons(
                    showFirst: !playing,
                    firstChild: const Icon(Icons.music_note),
                    secondChild: const Icon(Icons.pause),
                  ),
                  onTap: () {
                    viewModel.play(music);
                  },
                  onLongPress: () {
                    showLicense(context, music);
                  },
                ),
              );
            }),
          ),
        )
      ],
    );
  }

  void showLicense(BuildContext context, RelaxSoundModel music) {
    showOkAlertDialog(
      context: context,
      title: "License",
      message: music.license,
    );
  }

  SpSectionContents buildSoundSection(
    String title,
    List<RelaxSoundModel> sounds,
    BuildContext context,
  ) {
    return SpSectionContents(
      headline: title,
      // headlineColor: M3Color.of(context).onBackground,
      tiles: [
        GridView.builder(
          itemCount: sounds.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            RelaxSoundModel sound = sounds[index];
            bool playing = viewModel.playing(sound);
            IconData icon = sound.weatherIcon ?? Icons.music_note;

            int dayColor = sound.colorDayIndex ?? (index) % 6 + 1;
            Color? foregroundColor = M3Color.dayColorsOf(context)[dayColor];
            Color? backgroundColor = M3Color.dayColorsOf(context)[dayColor]?.withOpacity(0.1);
            Color? borderColor = M3Color.dayColorsOf(context)[dayColor];

            if (playing) {
              foregroundColor = M3Color.of(context).onPrimary;
              backgroundColor = M3Color.dayColorsOf(context)[dayColor];
              borderColor = Colors.transparent;
            }

            return SizedBox(
              width: 88,
              height: 88,
              child: AnimatedContainer(
                clipBehavior: Clip.hardEdge,
                duration: ConfigConstant.fadeDuration,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: ConfigConstant.circlarRadius1,
                  border: Border.all(color: borderColor ?? Theme.of(context).dividerColor, width: 1),
                ),
                child: Material(
                  borderRadius: ConfigConstant.circlarRadius1,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      viewModel.play(sound);
                    },
                    onLongPress: () => showLicense(context, sound),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: foregroundColor),
                        ConfigConstant.sizedBoxH1,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            sound.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: M3TextTheme.of(context).labelMedium?.copyWith(color: foregroundColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildQuote(BuildContext context) {
    return offsetBuilder(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Text(
              "Click here to add your favorite quote!",
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                textStyle: M3TextTheme.of(context).headlineMedium?.copyWith(color: M3Color.of(context).onSurface),
                shadows: <Shadow>[
                  Shadow(
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      builder: (offset, effectiveOffset, child) {
        return Container(
          transform: Matrix4.identity()..translate(0.0, offset * 0.5),
          child: AnimatedOpacity(
            opacity: 1 - min(max(effectiveOffset * 2, 0), 1),
            duration: ConfigConstant.fadeDuration,
            child: child,
          ),
        );
      },
    );
  }
}
