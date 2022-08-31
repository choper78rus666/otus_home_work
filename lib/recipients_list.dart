import 'package:flutter/material.dart';
import 'package:home_work/builder_delegate.dart';

// Вывод списка рецептов
class RecipientsList extends StatefulWidget {
  const RecipientsList({Key? key}) : super(key: key);

  @override
  State<RecipientsList> createState() => _RecipientsListState();
}

class _RecipientsListState extends State<RecipientsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildCustomList(context));
  }

  Widget _buildCustomList(BuildContext context) {
    return ListView.custom(
      padding: const EdgeInsets.all(16.0),
      childrenDelegate: recipientCardSliverDelegate,
    );
  }
}
