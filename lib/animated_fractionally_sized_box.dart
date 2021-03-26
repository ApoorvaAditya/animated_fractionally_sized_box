library animated_fractionally_sized_box;

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Animated version of [FractionallySizedBox] that gradually changes its values over a period of time.
///
/// The [AnimatedFractionallySizedBox] will automatically animate between the old and
/// new values of properties when they change using the provided curve and
/// duration. Properties that are null are not animated. Its child and
/// descendants are not animated.
///
/// This class is useful for generating simple implicit transitions between
/// different parameters to [FractionallySizedBox] with its internal [AnimationController].
/// For more complex animations, you'll likely want to use a subclass of
/// [AnimatedWidget] such as the [DecoratedBoxTransition] or use your own
/// [AnimationController].

class AnimatedFractionallySizedBox extends ImplicitlyAnimatedWidget {
  /// Creates a container that animates its parameters implicitly.
  ///
  /// The [curve] and [duration] arguments must not be null.
  /// If non-null, the [widthFactor] and [heightFactor] arguments must be
  /// non-negative.
  const AnimatedFractionallySizedBox({
    Key key,
    this.child,
    this.widthFactor,
    this.heightFactor,
    this.alignment = Alignment.center,
    @required Duration duration,
    Curve curve = Curves.linear,
    VoidCallback onEnd,
  })  : assert(widthFactor == null || widthFactor >= 0.0),
        assert(heightFactor == null || heightFactor >= 0.0),
        super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// If non-null, the fraction of the incoming width given to the child.
  ///
  /// If non-null, the child is given a tight width constraint that is the max
  /// incoming width constraint multiplied by this factor.
  ///
  /// If null, the incoming width constraints are passed to the child
  /// unmodified.
  final double widthFactor;

  /// If non-null, the fraction of the incoming height given to the child.
  ///
  /// If non-null, the child is given a tight height constraint that is the max
  /// incoming height constraint multiplied by this factor.
  ///
  /// If null, the incoming height constraints are passed to the child
  /// unmodified.
  final double heightFactor;

  /// How to align the child.
  ///
  /// The x and y values of the alignment control the horizontal and vertical
  /// alignment, respectively. An x value of -1.0 means that the left edge of
  /// the child is aligned with the left edge of the parent whereas an x value
  /// of 1.0 means that the right edge of the child is aligned with the right
  /// edge of the parent. Other values interpolate (and extrapolate) linearly.
  /// For example, a value of 0.0 means that the center of the child is aligned
  /// with the center of the parent.
  ///
  /// Defaults to [Alignment.center].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  @override
  _AnimatedFractionallySizedBoxState createState() => _AnimatedFractionallySizedBoxState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(DoubleProperty('widthFactor', widthFactor, defaultValue: null));
    properties.add(DoubleProperty('heightFactor', heightFactor, defaultValue: null));
  }
}

class _AnimatedFractionallySizedBoxState extends AnimatedWidgetBaseState<AnimatedFractionallySizedBox> {
  DoubleTween _widthFactor;
  DoubleTween _heightFactor;
  AlignmentGeometryTween _alignment;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: _widthFactor?.evaluate(animation),
      heightFactor: _heightFactor?.evaluate(animation),
      child: widget?.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _widthFactor = visitor(_widthFactor, widget.widthFactor, (dynamic value) => DoubleTween(begin: value as double))
        as DoubleTween;
    _heightFactor = visitor(_heightFactor, widget.heightFactor, (dynamic value) => DoubleTween(begin: value as double))
        as DoubleTween;
    _alignment = visitor(
            _alignment, widget.alignment, (dynamic value) => AlignmentGeometryTween(begin: value as AlignmentGeometry))
        as AlignmentGeometryTween;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(DiagnosticsProperty<AlignmentGeometryTween>('alignment', _alignment));
    description.add(DiagnosticsProperty<DoubleTween>('widthFactor', _widthFactor, defaultValue: null));
    description.add(DiagnosticsProperty<DoubleTween>('heightFactor', _heightFactor, defaultValue: null));
  }
}

class DoubleTween extends Tween<double> {
  DoubleTween({double begin, double end}) : super(begin: begin, end: end);

  @override
  double lerp(double t) => lerpDouble(begin, end, t);
}
