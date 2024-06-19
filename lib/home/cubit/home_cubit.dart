import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../utils/constants.dart';
import '../widget/movie_card.dart';
import 'models/movie_preview.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Dio _dio = GetIt.instance<Dio>();

  HomeCubit() : super(HomeState(movieCard: const []));

  Future<void> getMoviesPopular() async {
    List<MovieCard> movieCard = [];
    final response = await _dio.get(
      '$kThemoviedbURL/popular?api_key=$themoviedbApi',
    );

    for (var item in response.data["results"]) {
      movieCard.add(
        MovieCard(
          moviePreview: MoviePreview(
            year: (item["release_date"].toString().length > 4)
                ? item["release_date"].toString().substring(0, 4)
                : "",
            imageUrl: "$kThemoviedbImageURL${item["poster_path"]}",
            title: item["title"],
            id: item["id"].toString(),
            rating: item["vote_average"].toDouble(),
            overview: item["overview"],
          ),
        ),
      );
    }

    emit(
      state.copyWith(movieCard: movieCard),
    );
  }

  Future<void> getMoviesTopRated() async {
    List<MovieCard> movieCard = [];
    final response = await _dio.get(
      '$kThemoviedbURL/top_rated?api_key=$themoviedbApi',
    );

    for (var item in response.data["results"]) {
      movieCard.add(
        MovieCard(
          moviePreview: MoviePreview(
            year: (item["release_date"].toString().length > 4)
                ? item["release_date"].toString().substring(0, 4)
                : "",
            imageUrl: "$kThemoviedbImageURL${item["poster_path"]}",
            title: item["title"],
            id: item["id"].toString(),
            rating: item["vote_average"].toDouble(),
            overview: item["overview"],
          ),
        ),
      );
    }

    emit(
      state.copyWith(movieCard: movieCard),
    );
  }
}
