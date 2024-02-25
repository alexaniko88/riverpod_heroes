part of 'core.dart';

class Observers extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "ADDED"
}''');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "UPDATED"
}''');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "DISPOSED"
}''');
    super.didDisposeProvider(provider, container);
  }
}
