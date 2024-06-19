part of 'home_cubit.dart';

class HomeState extends Equatable {
  HomeState({
    required this.movieCard,
  });

  List<MovieCard> movieCard;

  HomeState copyWith({
    List<MovieCard>? movieCard,
  }) {
    return HomeState(
      movieCard: movieCard ?? this.movieCard,
    );
  }

  @override
  List<Object> get props => [movieCard];
}
