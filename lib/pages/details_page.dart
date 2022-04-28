import 'package:flutter/material.dart';
import 'package:my_movies/pages/details_page_extra.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../models/movies_model.dart';
import '../utils/apis_utils.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailsPage> {
  bool isFinished = false;

  //const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  tag: widget.movie.id,
                  child: Image.network(
                    API.REQUEST_IMG(widget.movie.posterPath),
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(widget.movie.overview),
              const SizedBox(height: 20),



              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: SwipeableButtonView(
                      buttonText: "Slide to get more details",
                      buttonWidget: Container(
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      activeColor:  const Color(0x40404034),
                      isFinished: isFinished,
                      onWaitingProcess: () {
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            isFinished = true;
                          });
                        });
                      },
                      onFinish: () async {
                        await Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child:  DetailsPageExtra(movie: widget.movie)));

                        setState(() {
                          isFinished = false;
                        });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
