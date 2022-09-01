import 'package:flutter/material.dart';
import 'configs/recipients.dart';
import 'package:home_work/helpers.dart';

// Формируем карточки для списка
final recipientCardSliverDelegate = SliverChildBuilderDelegate(
  (context, index) => Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      height: 136,
      child: Row(
        key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 149,
            height: 136,
            child: Image.asset(
              recipientsList[index]['imagePath'],
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    key: UniqueKey(),
                    children: [
                      SizedBox(
                        width: 208,
                        height: 52,
                        child: Text(
                          recipientsList[index]['title'] ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    key: UniqueKey(),
                    children: [
                      Icon(
                        Icons.access_time,
                        key: UniqueKey(),
                        size: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0),
                        child: Text(
                          timeToString(recipientsList[index]['time'] ?? 0),
                          key: UniqueKey(),
                          style: const TextStyle(
                            color: Color(0xff2ECC71),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
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
