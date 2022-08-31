import 'package:flutter/material.dart';
import 'configs/recipients.dart';

// Формируем карточки для списка
final recipientCardSliverDelegate = SliverChildBuilderDelegate(
  (context, index) => Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      height: 100,
      child: Row(
        key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/recipient_mini.png',
                fit: BoxFit.fill,
              )),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(key: UniqueKey(), children: [
                    Text(
                      recipientsList[index]['title'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                ),
                Expanded(
                  child: Row(
                    key: UniqueKey(),
                    children: [
                      Icon(Icons.access_time, key: UniqueKey()),
                      Padding(
                          padding: const EdgeInsets.only(left: 11.0),
                          child: Text(
                              '${recipientsList[index]['time'].toString()} минут',
                              key: UniqueKey(),
                              style: const TextStyle(
                                color: Color(0xff2ECC71),
                              ))),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  ),
  childCount: recipientsList.length,
);
