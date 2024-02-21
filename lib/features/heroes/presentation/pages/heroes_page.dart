part of '../../heroes.dart';

class HeroesPage extends ConsumerStatefulWidget {
  const HeroesPage({super.key});

  @override
  ConsumerState<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends ConsumerState<HeroesPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
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
      appBar: AppBar(title: Text(loc.heroesAppBarTitle)),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: state.heroes.length,
        padding: const EdgeInsets.all(defaultPadding),
        itemBuilder: (context, index) {
          final item = state.heroes[index];
          return Card(
            child: ListTile(
              leading: Hero(
                tag: item.id.toString(),
                child: AvatarView(
                  url: item.heroImagesModel?.sm ?? '',
                  width: leadingImageSize,
                ),
              ),
              title: Text(item.name ?? ''),
              subtitle: Text(item.biographyModel?.fullName ?? ''),
              trailing: Text(item.biographyModel?.publisher ?? ''),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
