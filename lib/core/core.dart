library core;

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_heroes/config/config.dart';


part 'domain/entities/result.dart';
part 'domain/entities/response.dart';
part 'exceptions/http_exception.dart';
part 'network/network_service.dart';
part 'network/dio_network_service.dart';
part 'mixins/exception_handler_mixin.dart';
part 'domain/providers/dio_network_service_provider.dart';
part 'observers.dart';
part 'constants.dart';