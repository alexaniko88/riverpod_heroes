part of '../core.dart';

extension IntExtensions on int {
  bool isBetween({
    required int from,
    required int to,
  }) =>
      from <= this && this < to;
}