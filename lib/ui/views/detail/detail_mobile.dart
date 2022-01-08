part of detail_view;

class _DetailMobile extends StatelessWidget {
  final DetailViewModel viewModel;
  const _DetailMobile(this.viewModel);

  FocusNode get focusNode => viewModel.focusNode;
  editor.QuillController get controller => viewModel.controller;
  ScrollController get scrollController => viewModel.scrollController;
  ValueNotifier<bool> get readOnlyNotifier => viewModel.readOnlyNotifier;
  TextEditingController get titleController => viewModel.titleController;
  ValueNotifier<bool> get hasChangeNotifer => viewModel.hasChangeNotifer;

  @override
  Widget build(BuildContext context) {
    return DetailScaffold(
      titleBuilder: (state) => buildTitle(state),
      editorBuilder: (state) => buildEditor(state),
      toolbarBuilder: (state) => buildToolbar(state),
      readOnlyNotifier: readOnlyNotifier,
      hasChangeNotifer: hasChangeNotifer,
      onSave: () => viewModel.save(),
      viewModel: viewModel,
    );
  }

  editor.QuillToolbar buildToolbar(GlobalKey<ScaffoldState> state) {
    return editor.QuillToolbar.basic(
      controller: controller,
      multiRowsDisplay: false,
      toolbarIconSize: ConfigConstant.iconSize2,
    );
  }

  Widget buildEditor(GlobalKey<ScaffoldState> state) {
    return ValueListenableBuilder<bool>(
      valueListenable: readOnlyNotifier,
      builder: (context, value, child) {
        return editor.QuillEditor(
          controller: controller,
          scrollController: scrollController,
          scrollable: true,
          focusNode: focusNode,
          autoFocus: false,
          readOnly: readOnlyNotifier.value,
          expands: false,
          padding: EdgeInsets.all(ConfigConstant.margin2).copyWith(
            bottom: kToolbarHeight + MediaQuery.of(context).viewPadding.bottom + ConfigConstant.margin2,
          ),
          keyboardAppearance: M3Color.keyboardAppearance(context),
        );
      },
    );
  }

  Widget buildTitle(GlobalKey<ScaffoldState> state) {
    return ValueListenableBuilder<bool>(
      valueListenable: readOnlyNotifier,
      builder: (context, value, child) {
        return TextField(
          style: M3TextTheme.of(context).titleLarge,
          autofocus: false,
          readOnly: readOnlyNotifier.value,
          controller: titleController,
          keyboardAppearance: M3Color.keyboardAppearance(context),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4.0),
            hintText: 'Title...',
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.zero,
            ),
          ),
        );
      },
    );
  }
}
