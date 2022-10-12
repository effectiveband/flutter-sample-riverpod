import 'package:flutter/material.dart';

class SliverWithoutScrollBody extends SliverFillRemaining {
  const SliverWithoutScrollBody({super.key, super.child})
      : super(hasScrollBody: false);
}
