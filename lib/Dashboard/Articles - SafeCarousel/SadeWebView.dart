import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../constants.dart';

class SafeWebView extends StatelessWidget {
  final String url;
  final String title;
  final int index;
  const SafeWebView({required Key key, required this.url, required this.title, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: CupertinoNavigationBar(
        middle: Text(title),
        trailing: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(imageSliders[index]),
        ),
      ),
    );
  }
}
