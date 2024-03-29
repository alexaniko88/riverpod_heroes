part of '../../heroes.dart';

abstract class HeroesDatasource {
  Future<Result<List<HeroModel>, AppException>> getAllHeroes();
}

class HeroesRemoteDatasource extends HeroesDatasource {
  final NetworkService networkService;

  HeroesRemoteDatasource(this.networkService);

  @override
  Future<Result<List<HeroModel>, AppException>> getAllHeroes() async {
    final response = await networkService.get(
      '/all.json',
    );
    return response.fold(
      (response) {
        final jsonData = response.data;
        if (jsonData == null) {
          return Result.failure(
            AppException(
              identifier: 'get all heroes',
              statusCode: StatusCode.noData,
              message: 'The data is not in the valid format.',
            ),
          );
        }
        final heroes = List<HeroModel>.from(
          response.data.map((x) => HeroModel.fromJson(x)),
        );
        return Result.success(heroes);
      },
      (f) => Result.failure(f),
    );
  }
}
