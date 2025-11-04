import 'package:flutter/material.dart';

class ProfileListTileModel {
  final Color? imageBackgroundColor;
  final void Function() onPressed;
  final String imageUrl;
  final String title;
  final String? description;

  const ProfileListTileModel({
    this.imageBackgroundColor,
    required this.onPressed,
    required this.imageUrl,
    required this.title,
    this.description,
  });
}
