part of music_view;

class _MusicMobile extends StatelessWidget {
  final MusicViewModel viewModel;
  const _MusicMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('MusicMobile'),
      ),
    );
  }
}
