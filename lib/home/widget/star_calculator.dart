import 'package:flutter/material.dart';

List<Widget> getStars({required double? rating, required double starSize}) {
  List<StarIcon> temp = [];
  if (rating != null) {
    for (var i = 0; i < rating ~/ 2; i++) {
      temp.add(StarIcon(
        icon: Icons.star,
        size: starSize,
      ));
    }
    if (rating > 0 && rating % 2 != 0) {
      temp.add(StarIcon(
        icon: Icons.star_half,
        size: starSize,
      ));
    }
    while (temp.length < 5) {
      temp.add(StarIcon(
        icon: Icons.star_border,
        size: starSize,
      ));
    }
  }
  return temp;
}

class StarIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const StarIcon({super.key, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.yellow,
      size: size,
    );
  }
}
