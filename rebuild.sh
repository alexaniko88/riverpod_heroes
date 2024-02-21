#!/usr/bin/env bash

flutter pub get
flutter gen-l10n --arb-dir="lib/l10n/arb"
flutter packages pub run build_runner build --delete-conflicting-outputs