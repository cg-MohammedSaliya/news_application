import 'package:flutter/material.dart';

class customTabBar extends StatelessWidget {
  const customTabBar({
    Key? key,
    required this.btnText,
    required this.onPressed,
  }) : super(key: key);

  final String btnText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage(
                    'https://www.newotani.co.jp/fileadmin/res/en/tokyo/offers/rosegarden/kv_01.jpg'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
