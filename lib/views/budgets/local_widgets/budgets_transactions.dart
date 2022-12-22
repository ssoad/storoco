import 'package:flutter/material.dart';
import 'package:spooky/core/db/databases/category_database.dart';
import 'package:spooky/core/db/databases/transaction_database.dart';
import 'package:spooky/core/db/models/base/base_db_list_model.dart';
import 'package:spooky/core/db/models/category_db_model.dart';
import 'package:spooky/core/db/models/transaction_db_model.dart';

class BudgetsTransactions extends StatefulWidget {
  const BudgetsTransactions({super.key});

  @override
  State<BudgetsTransactions> createState() => _BudgetsTransactionsState();
}

class _BudgetsTransactionsState extends State<BudgetsTransactions> {
  BaseDbListModel<TransactionDbModel>? transactionsModel;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final result = await TransactionDatabase.instance.fetchAll();
    setState(() {
      transactionsModel = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactionsModel?.items.length ?? 0,
      itemBuilder: (context, index) {
        TransactionDbModel transaction = transactionsModel!.items[index];

        return ListTile(
          title: Text("\$${transaction.amount}"),
          subtitle: FutureBuilder<CategoryDbModel?>(
            future: CategoryDatabase.instance.fetchOneCache(transaction.categoryId),
            builder: (context, snapshot) {
              return Text(snapshot.data?.name ?? "...");
            },
          ),
        );
      },
    );
  }
}
