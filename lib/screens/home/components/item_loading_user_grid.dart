import 'package:datting_social/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemLoadingCard extends StatelessWidget {
  const ItemLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 10.0),
        ],
      ),
      child: Shimmer.fromColors(
        highlightColor: Mytheme.kBackgroundColor,
        baseColor: const Color(0xFFE0E0E0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
              child: Center(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: double.infinity,
                        height: 20,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: double.infinity,
                        height: 15,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 30),
                        width: double.infinity,
                        height: 15,
                        color: Colors.grey[400],
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
