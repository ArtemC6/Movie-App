import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';
import '../cubit/models/movie_details.dart';

class DetailsInfo extends StatelessWidget {
  const DetailsInfo({
    super.key,
    required this.stars,
    required this.movieDetails,
  });

  final List<Widget> stars;
  final MovieDetails? movieDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shadowColor: Colors.transparent.withOpacity(0.1),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            leading: Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            automaticallyImplyLeading: false,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 22.0.h,
            actions: const [],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: SafeArea(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SafeArea(
                    child: Container(height: 22.h),
                  ),
                  imageUrl: movieDetails!.backgroundURL,
                  errorWidget: (context, url, error) => SafeArea(
                    child: Container(
                      height: 22.h,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.h),
                      child: Wrap(
                        children: [
                          Text(
                            "${movieDetails!.title} ",
                            style: kDetailScreenBoldTitle,
                          ),
                          Text(
                            (movieDetails!.year == "")
                                ? ""
                                : "(${movieDetails!.year})",
                            style: kDetailScreenRegularTitle,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.h),
                      child: Row(children: stars),
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(height: 1.h),
                  ],
                ),
                if (movieDetails!.overview != "")
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 1.h,
                              left: 1.h,
                              bottom: 1.h,
                            ),
                            child: Text(kStoryLineTitleText,
                                style: kSmallTitleTextStyle),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 1.h, left: 1.h, top: 1.h, bottom: 4.h),
                              child: Text(
                                movieDetails!.overview,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xFFC9C9C9)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
