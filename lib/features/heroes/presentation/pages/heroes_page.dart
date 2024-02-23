part of '../../heroes.dart';

class HeroesPage extends ConsumerWidget {
  const HeroesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final heroesNotifier = heroesNotifierProvider(ref.watch(heroesRepositoryProvider));
    final state = ref.watch(heroesNotifier);
    ref.listen(
      heroesNotifier.select((value) => value),
      ((previous, next) {
        //show Snackbar on failure
        if (next is Failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.value?.failure?.message.toString() ?? '')));
        }
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: switch (state) {
          AsyncData(:final value) => Text(
              value.filteredHeroes.isNotEmpty
                  ? '${loc.heroesAppBarTitle}: ${value.filteredHeroes.length}'
                  : loc.heroesAppBarTitle,
            ),
          _ => const Text('Heroes'),
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: () {
              final publishers = ref.read(heroesNotifier.notifier).getAllPublishers();
              HeroesFilters.show(context: context, publishers: publishers);
            },
          ),
        ],
      ),
      body: switch (state) {
        AsyncData(:final value) => ListView.builder(
            shrinkWrap: true,
            itemCount: value.filteredHeroes.length,
            padding: const EdgeInsets.all(defaultPadding),
            itemBuilder: (context, index) {
              final item = value.filteredHeroes[index];
              return Card(
                child: ListTile(
                  leading: Hero(
                    tag: item.id.toString(),
                    child: AvatarView(
                      url: item.imageUrl,
                      width: leadingImageSize,
                    ),
                  ),
                  title: Text(item.name ?? ''),
                  subtitle: Text(item.fullName),
                  trailing: Text(item.publisher),
                  onTap: () => context.push(RoutePath.heroDetails.value, extra: item),
                ),
              );
            },
          ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
