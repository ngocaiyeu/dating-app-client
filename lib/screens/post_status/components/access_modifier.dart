import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccessModifier extends StatelessWidget {
  final String accessModifier;
  final String valueAccessModifier;
  final String textAccess;
  final String detailTextAccess;
  final VoidCallback onclicked;
  const AccessModifier({
    Key? key,
    required this.accessModifier,
    required this.valueAccessModifier,
    required this.textAccess,
    required this.detailTextAccess,
    required this.onclicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(20),
              primary: (accessModifier == valueAccessModifier)
                  ? Colors.green
                  : Colors.grey[200],
              onPrimary: (accessModifier == valueAccessModifier)
                  ? Colors.white
                  : Colors.black,
              elevation: 0),
          onPressed: onclicked,
          icon: Icon((valueAccessModifier == 'Công khai >') ? Icons.public : (valueAccessModifier == 'Chỉ bạn bè >') ? CupertinoIcons.person_2 : CupertinoIcons.lock),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(textAccess,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(detailTextAccess,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal))
                ],
              ),
              Icon((accessModifier == valueAccessModifier) ? Icons.done : null)
            ],
          )),
    );
  }
}
