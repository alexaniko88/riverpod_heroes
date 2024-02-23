library heroes;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_heroes/core/core.dart';
import 'package:riverpod_heroes/l10n/l10n.dart';
import 'package:riverpod_heroes/navigation/navigation.dart';

part 'domain/entities/hero_model.dart';

part 'domain/repositories/heroes_repository.dart';

part 'heroes.freezed.dart';

part 'heroes.g.dart';

part 'presentation/pages/heroes_page.dart';

part 'data/repositories/heroes_repository_impl.dart';

part 'domain/providers/heroes_provider.dart';

part 'presentation/providers/state/heroes_state.dart';

part 'presentation/providers/state/heroes_notifier.dart';

part 'presentation/providers/heroes_providers.dart';

part 'presentation/widgets/avatar_view.dart';

part 'presentation/pages/hero_details_page.dart';

part 'presentation/widgets/heroes_filters.dart';

part 'data/datasource/heroes_remote_datasource.dart';
