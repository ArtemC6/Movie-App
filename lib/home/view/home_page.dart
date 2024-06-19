import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../utils/constants.dart';
import '../cubit/home_cubit.dart';
import '../widget/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onItemTapped(int index) async {
    if (index == 0) {
      context.read<HomeCubit>().getMoviesPopular();
    } else {
      context.read<HomeCubit>().getMoviesTopRated();
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.movieCard.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        List<MovieCard> filteredMovieCard = state.movieCard.where((movie) {
          String title = movie.moviePreview.title.toLowerCase();
          String searchQuery = _searchController.text.toLowerCase();

          return title.contains(searchQuery);
        }).toList();

        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent.withOpacity(0.1),
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: kAppBarColor,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: kSearch,
                  hintStyle: const TextStyle(color: Colors.white54),
                  icon: const Icon(Icons.search, color: Colors.white),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () =>
                              setState(() => _searchController.clear()),
                        )
                      : null,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              if (_selectedIndex == 0) {
                await context.read<HomeCubit>().getMoviesPopular();
              } else {
                await context.read<HomeCubit>().getMoviesTopRated();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AnimationLimiter(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: filteredMovieCard.length,
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: filteredMovieCard[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: kPopular,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: kTopRated,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
