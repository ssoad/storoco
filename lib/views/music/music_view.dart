library music_view;

// import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:spooky/core/base/view_model_provider.dart';
import 'music_view_model.dart';

part 'music_mobile.dart';
part 'music_tablet.dart';
part 'music_desktop.dart';

class MusicView extends StatelessWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MusicViewModel>(
      create: (context) => MusicViewModel(),
      builder: (context, viewModel, child) {
        return _MusicMobile(viewModel);
        // return ScreenTypeLayout(
        //   mobile: _MusicMobile(viewModel),
        //   desktop: _MusicDesktop(viewModel),
        //   tablet: _MusicTablet(viewModel),
        // );
      },
    );
  }
}
