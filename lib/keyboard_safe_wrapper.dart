
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'keyboard_safe_stub.dart'
    if (dart.library.js_interop) 'keyboard_safe_web.dart';

class KeyboardSafeWrapper extends StatefulWidget {
  final Widget child;

  const KeyboardSafeWrapper({super.key, required this.child});

  @override
  State<KeyboardSafeWrapper> createState() => _KeyboardSafeWrapperState();
}

class _KeyboardSafeWrapperState extends State<KeyboardSafeWrapper> {
  double keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    if (isIosWeb) {
      setupKeyboardListener((height) {
        setState(() => keyboardHeight = height);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isIosWeb
        ? Padding(
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: widget.child,
          )
        : Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: widget.child,
          );
  }

  @override
  void dispose() {
    disposeKeyboardListener();
    super.dispose();
  }

  bool get isIosWeb => kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
}
