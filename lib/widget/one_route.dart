import 'package:flutter/cupertino.dart';

class OneRoute extends PageRoute {
  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  OneRoute(
      {this.builder,
      this.transitionDuration,
      this.opaque,
      this.barrierDismissible,
      this.barrierColor,
      this.barrierLabel,
      this.maintainState});

  // @override
  // // TODO: implement barrierColor
  // Color get barrierColor => throw UnimplementedError();
  //
  // @override
  // // TODO: implement barrierLabel
  // String get barrierLabel => throw UnimplementedError();

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }

  // @override
  // // TODO: implement maintainState
  // bool get maintainState => throw UnimplementedError();
  //
  // @override
  // // TODO: implement transitionDuration
  // Duration get transitionDuration => throw UnimplementedError();
}
