library music_view;

// import 'package:responsive_builder/responsive_builder.dart';
import 'dart:math';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spooky/core/base/view_model_provider.dart';
import 'package:spooky/core/models/relax_sound_model.dart';
import 'package:spooky/core/models/sound_model.dart';
import 'package:spooky/theme/m3/m3_color.dart';
import 'package:spooky/theme/m3/m3_text_theme.dart';
import 'package:spooky/utils/constants/config_constant.dart';
import 'package:spooky/utils/extensions/string_extension.dart';
import 'package:spooky/views/music/local_widgets/music_background_gradients.dart';
import 'package:spooky/views/music/local_widgets/music_background_image.dart';
import 'package:spooky/widgets/sp_animated_icon.dart';
import 'package:spooky/widgets/sp_developer_visibility.dart';
import 'package:spooky/widgets/sp_icon_button.dart';
import 'package:spooky/widgets/sp_pop_button.dart';
import 'package:spooky/widgets/sp_sections_tiles.dart';
import 'package:spooky/widgets/sp_theme_switcher.dart';
import 'music_view_model.dart';

part 'music_mobile.dart';
part 'music_tablet.dart';
part 'music_desktop.dart';

class MusicView extends StatelessWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeProvider provider = Provider.of<ThemeProvider>(context, listen: true);
    return Theme(
      data: Theme.of(context),
      child: ViewModelProvider<MusicViewModel>(
        create: (context) => MusicViewModel(),
        builder: (context, viewModel, child) {
          return _MusicMobile(viewModel);
          // return ScreenTypeLayout(
          //   mobile: _MusicMobile(viewModel),
          //   desktop: _MusicDesktop(viewModel),
          //   tablet: _MusicTablet(viewModel),
          // );
        },
      ),
    );
  }
}
