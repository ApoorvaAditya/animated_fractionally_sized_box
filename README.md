**AnimatedFractionallySizedBox is part of Flutter's widgets library now. Please use that instead since this package will not be maintained.**

---
# animated_fractionally_sized_box

Animated version of `FractionallySizedBox` that gradually changes its values over a period of time.

## Description

The `AnimatedFractionallySizedBox` will automatically animate between the old and new values of properties when they change using the provided curve and duration. Properties that are null are not animated. Its child and descendants are not animated.

## Usage
- Add this line to pubspec.yaml
```
dependencies:
  animated_fractionally_sized_box: ^2.0.1
```
- Import package
```
import 'package:animated_fractionally_sized_box/animated_fractionally_sized_box.dart';
```
- Use it the same as a FractionallySizedBox
```
AnimatedFractionallySizedBox(
    widthFactor: widthFactor,
    heightFactor: heightFactor,
    alignment: Alignment.centerLeft,
    child: ...
)
```
- See example for usage
