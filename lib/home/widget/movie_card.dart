import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../details/view/details_page.dart';
import '../../utils/constants.dart';
import '../cubit/models/movie_preview.dart';
import 'star_calculator.dart';

class MovieCard extends StatelessWidget {
  final MoviePreview moviePreview;

  const MovieCard({
    super.key,
    required this.moviePreview,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = getStars(rating: moviePreview.rating, starSize: 20.0);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(id: moviePreview.id),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 20,
                    color: Colors.grey[200],
                  ),
                  imageUrl: moviePreview.imageUrl!,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: kAppBarColor.withOpacity(0.8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          moviePreview.title,
                          style: kBoldTitleTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          moviePreview.year.isEmpty
                              ? ""
                              : "(${moviePreview.year})",
                          style: kTitleTextStyle,
                        ),
                        const SizedBox(height: 4),
                        if (stars.isNotEmpty) Row(children: stars),
                        const SizedBox(height: 4),
                        Text(
                          moviePreview.overview,
                          style: kSubTitleCardBoxTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
