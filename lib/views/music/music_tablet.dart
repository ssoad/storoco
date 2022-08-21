part of music_view;

class _MusicTablet extends StatelessWidget {
  final MusicViewModel viewModel;
  const _MusicTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('MusicTablet'),
      ),
    );
  }
}
