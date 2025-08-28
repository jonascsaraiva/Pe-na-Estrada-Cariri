import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//Efeito de carregamento
Widget shimmerPlaceholder({double? height, double? width}) {
  return Shimmer.fromColors(
    baseColor: const Color(0xFFE0E0E0),
    highlightColor: Colors.white,
    child: Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      color: Colors.grey[300],
    ),
  );
}
