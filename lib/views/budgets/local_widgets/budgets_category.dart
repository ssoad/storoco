import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spooky/core/db/databases/category_database.dart';
import 'package:spooky/core/db/models/category_db_model.dart';
import 'package:spooky/utils/helpers/date_format_helper.dart';
import 'package:spooky/utils/mixins/schedule_mixin.dart';

class BudgetsCategory extends StatefulWidget {
  const BudgetsCategory({super.key});

  @override
  State<BudgetsCategory> createState() => _BudgetsCategoryState();
}

class _BudgetsCategoryState extends State<BudgetsCategory> with ScheduleMixin {
  final CategoryDatabase categoryDatabase = CategoryDatabase.instance;
  late final ValueNotifier<List<int>> selectedCategoriesIdNotifier;
  List<CategoryDbModel>? categories;

  @override
  void initState() {
    super.initState();
    selectedCategoriesIdNotifier = ValueNotifier<List<int>>([]);
    load();
  }

  Future<void> load() async {
    final result = await categoryDatabase.fetchAll();
    setState(() {
      categories = result?.items ?? [];
    });
  }

  void setSelected(int id, bool bool) {}

  DialogTextField buildTagField(CategoryDbModel? object) {
    return DialogTextField(
      initialText: object?.name,
      hintText: tr("field.budget_category.hint_text"),
    );
  }

  Future<void> onCreate(BuildContext context) async {
    List<String>? result = await showTextInputDialog(
      context: context,
      title: tr("alert.create_budgets_category.title"),
      okLabel: tr("button.ok"),
      cancelLabel: tr("button.cancel"),
      textFields: [
        buildTagField(null),
      ],
    );

    if (result != null) {
      String title = result[0];
      await create(title);
    }
  }

  // make sure to validate before call
  Future<void> create(String title) async {
    final now = DateTime.now();
    await categoryDatabase.create(
      body: CategoryDbModel(
        id: 0,
        position: 0,
        type: "income",
        name: title,
        budget: null,
        icon: null,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: categories?.length ?? 0,
          itemBuilder: (context, index) {
            final category = categories![index];
            return ValueListenableBuilder<List<int>>(
              valueListenable: selectedCategoriesIdNotifier,
              builder: (context, selectedIds, child) {
                return CheckboxListTile(
                  value: selectedIds.contains(category.id),
                  title: Text(category.name),
                  subtitle: Text(DateFormatHelper.dateTimeFormat().format(category.createdAt)),
                  onChanged: (value) => setSelected(category.id, value == true),
                );
              },
            );
          },
        ),
        ListTile(
          title: Text(tr("button.add")),
          leading: const Icon(Icons.add),
          onTap: () async {
            await onCreate(context);
          },
        ),
      ],
    );
  }
}
