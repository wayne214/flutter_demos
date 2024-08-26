import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ConformDialog extends StatelessWidget {
  final String title;
  final String msg;
  final String conformText;
  final VoidCallback onConform;

  ConformDialog(
      {super.key,
      required this.title,
      required this.msg,
      required this.conformText,
      required this.onConform});

  final ButtonStyle conformStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
    foregroundColor: Colors.white,
    elevation: 0,
    minimumSize: const Size(70, 35),
    padding: EdgeInsets.zero,
    shape: const StadiumBorder(),
  );

  final ButtonStyle cancelStyle = OutlinedButton.styleFrom(
    minimumSize: const Size(70, 35),
    elevation: 0,
    padding: EdgeInsets.zero,
    shape: const StadiumBorder(),
  );

  Widget _buildTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget _buildMessage() => Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
        ),
        child: Text(
          msg,
          style: const TextStyle(fontSize: 14),
        ),
      );

  Widget _buildButtons(BuildContext context) => Row(
        children: [
          const Spacer(),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: cancelStyle,
            child: const Text(
              "取消",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: onConform,
              style: conformStyle,
              child: Text(
                conformText,
              ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildMessage(),
            _buildButtons(context),
          ],
      ),
    ));
  }
}
