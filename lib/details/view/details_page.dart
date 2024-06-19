import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../home/widget/star_calculator.dart';
import '../cubit/details_cubit.dart';
import '../widget/details_info.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  const DetailsScreen({
    super.key,
    required this.id,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..getMovieDetails(movieID: widget.id),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if ((state.movieDetails?.title ?? '').isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          final stars =
              getStars(rating: state.movieDetails!.rating, starSize: 15.sp);

          return DetailsInfo(
            stars: stars,
            movieDetails: state.movieDetails,
          );
        },
      ),
    );
  }
}
