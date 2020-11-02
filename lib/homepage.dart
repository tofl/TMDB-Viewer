import 'package:flutter/material.dart';
import 'viewFilm.dart';
import 'API/API.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body:
      Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xff303030),
            ),
          ),

          SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Popular Movies',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),

                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                            future: TMDBRepo.fetchPopularMovies(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                List<Widget> trending = [];
                                snapshot.data.forEach((movie) => {
                                  trending.add(
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFilm(show: movie, type: 'movie')));
                                      },

                                      child: Container(
                                        width: 120,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: NetworkImage(movie.poster),
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                });
                                return ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: trending,
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Could not retrieve popular movies. Please try again later.',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                );
                              } else {
                                return Text('Loading...');
                              }
                            }
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Popular TV Shows',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                            future: TMDBRepo.fetchPopularSeries(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Could not retrieve popular series. Please try again later.'
                                );
                              } else if (snapshot.hasData) {
                                List<Widget> trending = [];
                                snapshot.data.forEach((series) => {
                                  trending.add(
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFilm(show: series, type: 'series')));
                                      },

                                      child: Container(
                                        width: 120,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: NetworkImage(series.poster),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                });

                                return ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: trending,
                                );
                              } else {
                                return Text('Loading...');
                              }
                            }
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Best Movies',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                            future: TMDBRepo.fetchBestMovies(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                List<Widget> trending = [];
                                snapshot.data.forEach((movie) => {
                                  trending.add(
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFilm(show: movie, type: 'movie')));
                                      },

                                      child: Container(
                                        width: 120,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),

                                            image: DecorationImage(
                                              image: NetworkImage(movie.poster),
                                              fit: BoxFit.cover,
                                            )

                                        ),
                                      ),
                                    ),
                                  ),
                                });
                                return ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: trending,
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Could not retrieve popular movies. Please try again later.',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                );
                              } else {
                                return Text('Loading...');
                              }
                            }
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}