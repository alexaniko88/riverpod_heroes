library core;

import 'dart:developer';
import 'dart:io';

import 'package:basic_flutter_helper/basic_flutter_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_heroes/config/config.dart';

part 'constants.dart';

part 'shared.g.dart';

part 'domain/entities/response.dart';

part 'domain/entities/result.dart';

part 'domain/providers/dio_network_service_provider.dart';

part 'exceptions/app_exception.dart';

part 'extensions/int_extensions.dart';

part 'mixins/exception_handler_mixin.dart';

part 'network/dio_network_service.dart';

part 'network/network_service.dart';

part 'observers.dart';
