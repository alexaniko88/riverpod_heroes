part of '../../heroes.dart';

class HeroesPage extends ConsumerStatefulWidget {
  const HeroesPage({super.key});

  @override
  HeroesPageState createState() => HeroesPageState();
}

class HeroesPageState extends ConsumerState<HeroesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(heroesNotifierProvider(ref.watch(heroesRepositoryProvider)).notifier).getAllHeroes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final heroesNotifier = heroesNotifierProvider(ref.watch(heroesRepositoryProvider));
    final state = ref.watch(heroesNotifier);
    ref.listen(
      heroesNotifier,
      ((previous, next) {
        if (next.status == HeroesStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.failure?.message.toString() ?? '')));
        }
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(state.filteredHeroes.isNotEmpty
            ? '${loc.heroesAppBarTitle}: ${state.filteredHeroes.length}'
            : loc.heroesAppBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: () {
              HeroesFilters.show(context: context, publishers: state.getAllPublishers());
            },
          ),
        ],
      ),
      body: switch (state.status) {
        HeroesStatus.success => ListView.builder(
            shrinkWrap: true,
            itemCount: state.filteredHeroes.length,
            padding: const EdgeInsets.all(defaultPadding),
            itemBuilder: (context, index) {
              final item = state.filteredHeroes[index];
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
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
