// ignore_for_file: file_names

enum ImageEnum { add, bmi, equal, more, tax, hand, logarithm, trigonometry }

extension ImageGenerator on ImageEnum {
  String get toPath => "assets/$name.png";
}
