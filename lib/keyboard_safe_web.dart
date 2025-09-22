import 'dart:js_interop';

import 'package:web/web.dart' as web;

JSFunction? _resizeListener;
JSFunction? _scrollListener;

void setupKeyboardListener(Function(double) onChange) {
  _resizeListener = _onViewportChange(onChange);
  _scrollListener = _onViewportChange(onChange);

  web.window.visualViewport?.addEventListener('resize', _resizeListener);
  web.window.visualViewport?.addEventListener('scroll', _scrollListener);
}

void disposeKeyboardListener() {
  if (_resizeListener != null) {
    web.window.visualViewport?.removeEventListener('resize', _resizeListener!);
    _resizeListener = null;
  }
  if (_scrollListener != null) {
    web.window.visualViewport?.removeEventListener('scroll', _scrollListener!);
    _scrollListener = null;
  }
}

JSFunction _onViewportChange(Function(double) onChange) {
  return () {
    final viewportHeight = web.window.visualViewport?.height ?? 0;
    final windowHeight = web.window.innerHeight;
    onChange((windowHeight - viewportHeight).toDouble());
  }.toJS;
}


