part of music_view;

class _MusicDesktop extends StatelessWidget {
  final MusicViewModel viewModel;
  const _MusicDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('MusicDesktop'),
      ),
    );
  }
}
