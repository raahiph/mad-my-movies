import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movies_model.dart';
import '../utils/apis_utils.dart';

class DetailsPageExtra extends StatelessWidget {
  const DetailsPageExtra({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  tag: movie.id,
                  child: Image.network(
                    API.REQUEST_IMG(movie.posterPath),
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Text(movie.originalTitle),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Icon(Icons.calendar_today_sharp),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      movie.releaseDate,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      movie.originalLanguage,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(Icons.new_releases),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      movie.genreIds.asMap().toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
