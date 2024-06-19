import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../utils/constants.dart';
import 'models/movie_details.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final Dio _dio = GetIt.instance<Dio>();

  DetailsCubit() : super(const DetailsState());

  Future<void> getMovieDetails({required String movieID}) async {
    final response = await _dio.get(
      '$kThemoviedbURL/$movieID?api_key=$themoviedbApi&language=en-US',
    );

    final data = response.data;

    List<String> temp = [];
    List<int> genreIdsTemp = [];
    for (var item in data["genres"]) {
      temp.add(item["name"]);
      genreIdsTemp.add(item["id"]);
    }

    final movieDetails = MovieDetails(
      backgroundURL: "https://image.tmdb.org/t/p/w500${data["backdrop_path"]}",
      title: data["title"],
      year: (data["release_date"].toString().length > 4)
          ? data["release_date"].toString().substring(0, 4)
          : "",
      rating: data["vote_average"].toDouble(),
      genres: Map.fromIterables(temp, genreIdsTemp),
      overview: data["overview"],
    );

    emit(
      state.copyWith(movieDetails: movieDetails),
    );
  }
}
