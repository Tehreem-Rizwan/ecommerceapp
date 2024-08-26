import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsAppbar extends StatelessWidget {
  const DetailsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(17),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(13),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 27,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Spacer(),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(13),
            ),
            onPressed: () {},
            iconSize: 27,
            icon: const Icon(Icons.share_outlined),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(13),
            ),
            onPressed: () {},
            iconSize: 27,
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
