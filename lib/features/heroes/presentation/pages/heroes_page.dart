part of '../../heroes.dart';

class HeroesPage extends ConsumerStatefulWidget {
  const HeroesPage({super.key});

  @override
  ConsumerState<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends ConsumerState<HeroesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(heroesStateNotifierProvider.notifier).getAllHeroes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final state = ref.watch(heroesStateNotifierProvider);
    ref.listen(
      heroesStateNotifierProvider.select((value) => value),
      ((previous, next) {
        //show Snackbar on failure
        if (next is Failure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.failure?.message.toString() ?? '')));
        }
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.filteredHeroes.isNotEmpty ? '${loc.heroesAppBarTitle}: ${state.filteredHeroes.length}' : loc.heroesAppBarTitle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: () {
              final publishers = ref.read(heroesStateNotifierProvider.notifier).getAllPublishers();
              HeroesFilters.show(context: context, publishers: publishers);
            },
          ),
        ],
      ),
      body: state.status == HeroesStatus.success
          ? ListView.builder(
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
