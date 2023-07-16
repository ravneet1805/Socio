import 'package:flutter/material.dart';

import 'constants.dart';


class ReceiverBubble extends StatelessWidget {
  final String message;

  const ReceiverBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kTileColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
