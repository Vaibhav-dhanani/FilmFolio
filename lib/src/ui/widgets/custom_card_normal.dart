import 'package:flutter/cupertino.dart';
import 'package:filmfolio/src/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CustomCardNormal extends StatelessWidget {
  Movie movie;
   CustomCardNormal({super.key,required this.movie});

  @override
  Widget build( BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 280,
            width: 160,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
              [Colors.black.withOpacity(0.8),
              Colors.transparent,],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: AssetImage(movie.images!), fit: BoxFit.cover)
            ),

          ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.name!,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.year!,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 5),


                  ],
                ),
              ),
              const SizedBox(width: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.rating?.toString() ?? "N/A",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    FontAwesomeIcons.solidStar,
                    size: 15,
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 5,)

                ],
              )
            ],
          ),
        ),


      ],
    );
  }
}
