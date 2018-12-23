import 'dart:math';

double K(double progress) {
  return sin(progress * (pi / 200));
}

double Z(double progress) {
  return cos(progress * (pi / 200));
}

double X(double progress) {
  return tan(progress * (pi / 200));
}

double rad(double progress) {
  return progress * (pi / 200);
}
