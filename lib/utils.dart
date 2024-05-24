import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Loading"),
                CupertinoActivityIndicator(),
              ],
            ),
          ));
}
