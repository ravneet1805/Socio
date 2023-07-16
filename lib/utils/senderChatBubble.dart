import 'package:flutter/material.dart';
import 'package:socio/utils/constants.dart';


class SenderBubble extends StatelessWidget {
  final String message;


  const SenderBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kSecondaryColor,
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
