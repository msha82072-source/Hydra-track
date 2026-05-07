import 'package:flutter/material.dart';

class Cup {
  final String id;
  final String name;
  final int amount; // in ml
  final IconData icon;

  Cup({
    required this.id,
    required this.name,
    required this.amount,
    required this.icon,
  });
}
