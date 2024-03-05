part of '../shared.dart';

extension IntExtensions on int {
  bool isBetween({
    required int from,
    required int to,
  }) =>
      from <= this && this < to;
}