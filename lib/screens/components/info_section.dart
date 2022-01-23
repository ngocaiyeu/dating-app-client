import 'package:flutter/material.dart';

class InfoSectionWidget extends StatelessWidget {
  final String? following;
  final String? follower;
  final String? like;
  const InfoSectionWidget({Key? key, this.following, this.follower, this.like})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, "$following", "Following"),
          buildDivider(),
          buildButton(context, "$follower", "Followers"),
          buildDivider(),
          buildButton(context, "$like", "Like"),
        ],
      );

  // ignore: sized_box_for_whitespace
  Widget buildDivider() => Container(
      height: 25,
      child: const VerticalDivider(
        color: Colors.blue,
      ));

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 5),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
