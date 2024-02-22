part of '../../heroes.dart';
class AvatarView extends StatelessWidget {
  final String url;
  final double width;
  final bool useDecoration;

  const AvatarView({
    super.key,
    required this.url,
    required this.width,
    this.useDecoration = true,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      placeholder: (context, url) => _buildPlaceHolder(),
      errorWidget: (context, url, error) => _buildPlaceHolder(),
      imageBuilder: useDecoration
          ? (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      )
          : null,
    );
  }

  Widget _buildPlaceHolder() => Image.asset(
    Assets.questionMark,
    width: heroDetailsImageWidth,
  );
}