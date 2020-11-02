import 'package:flutter/material.dart';
import 'API/API.dart';

class ViewFilm extends StatefulWidget {
  ViewFilm({Key key, this.show, this.type}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;
  final ShowPreview show;
  final String type;

  @override
  _ViewFilmState createState() => _ViewFilmState(show, type);
}

class _ViewFilmState extends State<ViewFilm> {
  ShowPreview show;
  Future<Show> request;
  List<Widget> genres = [];

  _ViewFilmState(ShowPreview show, String type) {
    this.show = show;
    if (type == 'movie') {
      this.request = TMDBRepo.fetchMovie(show.id);
    } else if (type == 'series') {
      this.request = TMDBRepo.fetchSeries(show.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.transparent,
      ),
      body:
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(show.poster),
                  fit: BoxFit.cover,
                )
              ),
            ),

            Container(
              child: FutureBuilder(
                future: this.request,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // Add all the genres
                    snapshot.data.genres.forEach((genre) {
                      this.genres.add(Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white,
                        ),
                        child: Text(
                          genre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ));
                    });

                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment(-1.0, 1.0),
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.06,
                          ),
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.blueAccent),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xff303030)],
                            ),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                              child:Text(
                                snapshot.data.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              )
                          ),
                        ),

                        Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height * 0.49,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff303030),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // 15+ - 2020 - 7.6
                                    Row(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(right: 7),
                                            child: Text(
                                              '15+',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 7, right: 7),
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 7, right: 7),
                                            child: Text(
                                              snapshot.data.year.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 7, right: 7),
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 7),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Color(0xffe8a656),
                                                size: 20,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(left: 7),
                                                  child: Text(
                                                    snapshot.data.score,
                                                    style: TextStyle(
                                                      color: Color(0xffe8a656),
                                                    ),
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Crime, Drama, Mystery
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: genres,
                                      ),
                                    ),

                                    // Cast
                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Cast: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: snapshot.data.cast.sublist(0, (snapshot.data.cast.length < 4) ? snapshot.data.cast.length : 4).join(', '),
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                height: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Text(
                                        'Summary',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        snapshot.data.summary,
                                        style: TextStyle(
                                          color: Colors.white,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            )
                        )
                      ],
                    );
                  } else {
                    return Text('There was an error. Try again later.');
                  }
                },
              ),
            ),
          ],
        ),
    );
  }
}
