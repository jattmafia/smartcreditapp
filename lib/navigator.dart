import 'package:flutter/material.dart';

navigateTo(BuildContext context, route) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => route));
}

replaceTo(BuildContext context, route) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (_) => route), (route) => false);
}

back(BuildContext context) {
  Navigator.pop(context);
}
