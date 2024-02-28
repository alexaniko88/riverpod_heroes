import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_heroes/features/heroes/heroes.dart';
import 'package:riverpod_heroes/l10n/l10n.dart';
import 'package:riverpod_heroes/navigation/navigation.dart';
import 'package:riverpod_heroes/shared/shared.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  late final String mockHeroesJson;
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockHeroesJson = await rootBundle.loadString('assets/tests/mock_heroes.json');
  });

  group('Heroes Page Tests', () {
    late final NetworkService networkService;

    setUpAll(() {
      networkService = MockNetworkService();
    });

    tearDown(() {});

    testWidgets(
      'Having a json file with 10 items When home page is rendered Then the list is displayed with 10 heroes',
      (WidgetTester tester) async {
        when(
          () => networkService.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Future.value(Result.success(NetworkResponse(statusCode: 0, data: json.decode(mockHeroesJson)))),
        );
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              networkServiceProvider.overrideWithValue(networkService),
            ],
            child: const MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('en'),
              home: HeroesPage(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Heroes: 10'), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(ListTile), findsWidgets);
        expect(find.byIcon(Icons.filter_list_alt), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    testWidgets(
      'Having an error from server When home page is rendered Then the circular progress indicator is displayed',
      (WidgetTester tester) async {
        when(
          () => networkService.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Future.value(
              Result.failure(AppException(statusCode: -1, message: 'Something went wrong', identifier: 'SOME_ERROR'))),
        );
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              networkServiceProvider.overrideWithValue(networkService),
            ],
            child: const MaterialApp(
              localizationsDelegates: [
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale('en'),
              home: HeroesPage(),
            ),
          ),
        );

        await tester.pump();

        expect(find.text('Heroes: 10'), findsNothing);
        expect(find.text('Heroes'), findsOneWidget);
        expect(find.byType(ListView), findsNothing);
        expect(find.byType(ListTile), findsNothing);
        expect(find.byIcon(Icons.filter_list_alt), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pump(1.seconds);
      },
    );
  });

  group("Heroes page + hero details page", () {
    late final NetworkService networkService;

    setUpAll(() {
      networkService = MockNetworkService();
    });

    tearDown(() {});
    testWidgets(
      'Having a json file with 10 items When home page is rendered and tapping the first item Then the details page is displayed',
      (WidgetTester tester) async {
        when(
          () => networkService.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Future.value(Result.success(NetworkResponse(statusCode: 0, data: json.decode(mockHeroesJson)))),
        );
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              networkServiceProvider.overrideWithValue(networkService),
            ],
            child: MaterialApp.router(
              localizationsDelegates: const [
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: const Locale('en'),
              routeInformationProvider: Routes.router.routeInformationProvider,
              routeInformationParser: Routes.router.routeInformationParser,
              routerDelegate: Routes.router.routerDelegate,
            ),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.byType(ListTile).first);
        await tester.pumpAndSettle();

        expect(find.byType(HeroDetailsPage), findsOneWidget);
        expect(find.descendant(of: find.byType(HeroDetailsPage), matching: find.byType(Hero)), findsOneWidget);
        expect(find.descendant(of: find.byType(HeroDetailsPage), matching: find.byType(AvatarView)), findsOneWidget);
      },
    );
  });

  group("Heroes page + filtering", () {
    late final NetworkService networkService;

    setUpAll(() {
      networkService = MockNetworkService();
    });

    tearDown(() {});
    testWidgets(
      'Having a json file with 10 items When home page is rendered and tapping the filter icon item Then the filtering is displayed',
          (WidgetTester tester) async {
        when(
              () => networkService.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
              (_) async => Future.value(Result.success(NetworkResponse(statusCode: 0, data: json.decode(mockHeroesJson)))),
        );
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              networkServiceProvider.overrideWithValue(networkService),
            ],
            child: MaterialApp.router(
              localizationsDelegates: const [
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: const Locale('en'),
              routeInformationProvider: Routes.router.routeInformationProvider,
              routeInformationParser: Routes.router.routeInformationParser,
              routerDelegate: Routes.router.routerDelegate,
            ),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.filter_list_alt));
        await tester.pumpAndSettle();

        expect(find.byType(HeroesFilters), findsOneWidget);
        expect(find.text('All'), findsOneWidget);

        await tester.tap(find.text('All'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('DC Comics').last);
        await tester.pumpAndSettle();

        expect(find.byType(ListTile), findsNWidgets(2));
      },
    );
  });
}
