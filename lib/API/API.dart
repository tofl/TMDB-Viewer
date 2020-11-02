import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

const API_KEY = '465dc57d6c321ec673e663edba2786b3';

class Show {
  int id;
  String title;
  String score;
  String summary;
  int year;
  List<String> genres;
  List<String> cast;
  String poster;

  Show(int id, String title, String summary, String poster, String score, int year, List<String> cast, List<String> genres) {
    this.id = id;
    this.title = title;
    this.summary = summary;
    this.poster = poster;
    this.score = score;
    this.year = year;
    this.cast = cast;
    this.genres = genres;
  }
}

class ShowPreview {
  int id;
  String poster;

  ShowPreview(int id, String poster) {
    this.id = id;
    this.poster = poster;
  }
}

class TMDBRepo {
  static Future<List<ShowPreview>> fetchPopularMovies() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?api_key=' + API_KEY + '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';

    List<ShowPreview> popularMovies = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parsedBody = jsonDecode(response.body);
      parsedBody['results'].forEach((movie) {

        String posterPath;
        if (movie['poster_path'] == null) {
          posterPath = 'https://i2.wp.com/www.theatrecr.org/wp-content/uploads/2016/01/poster-placeholder.png';
        } else {
          posterPath = 'https://image.tmdb.org/t/p/w1280' + movie['poster_path'];
        }

        popularMovies.add(new ShowPreview(movie['id'], posterPath));

        /*
        popularMovies.add(new Show(
          movie['id'],
          movie['original_title'],
          movie['overview'],
          posterPath,
          movie['vote_average'].toString(),
          int.parse(movie['release_date'].split('-')[0]),
          [],
          [],
        ));*/
      });
    }

    return popularMovies;
  }

  static Future<List<ShowPreview>> fetchPopularSeries() async {
    String url = 'https://api.themoviedb.org/3/discover/tv?api_key=' + API_KEY + '&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false';
    
    List<ShowPreview> popularSeries = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parsedBody = jsonDecode(response.body);

      parsedBody['results'].forEach((series) {
        // Credits
        /*
        final creditsResponse = await http.get('http://api.themoviedb.org/3/movie/' + series['id'].toString() + '/credits?api_key=' + API_KEY);
        final credits = jsonDecode(creditsResponse.body);
        List<String> castList = [];
        if (credits['cast'] != null) {
          credits['cast'].forEach((cast) {
            castList.add(cast['name']);
          });
        }
         */

        String posterPath;
        if (series['poster_path'] == null) {
          posterPath = 'https://i2.wp.com/www.theatrecr.org/wp-content/uploads/2016/01/poster-placeholder.png';
        } else {
          posterPath = 'https://image.tmdb.org/t/p/w1280' + series['poster_path'];
        }

        popularSeries.add(new ShowPreview(series['id'], posterPath));

        /*
        popularSeries.add(new Show(
          series['id'],
          series['original_name'],
          series['overview'],
          posterPath,
          series['vote_average'].toString(),
          int.parse(series['first_air_date'].split('-')[0]),
          [],
          [],
        ));
        */
      });
    }

    return popularSeries;
  }

  static Future<List<ShowPreview>> fetchBestMovies() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?api_key=' + API_KEY + '&language=en-US&sort_by=vote_average.desc&include_adult=false&include_video=false&page=1&ote_count.gte=1000';

    List<ShowPreview> bestMovies = [];

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parsedBody = jsonDecode(response.body);

      parsedBody['results'].forEach((movie) {
        // Credits
        /*
        final creditsResponse = await http.get('http://api.themoviedb.org/3/movie/' + movie['id'].toString() + '/credits?api_key=' + API_KEY);
        final credits = jsonDecode(creditsResponse.body);
        List<String> castList = [];
        if (credits['cast'] != null) {
          credits['cast'].forEach((cast) {
            castList.add(cast['name']);
          });
        }*/

        String posterPath;
        if (movie['poster_path'] == null) {
          posterPath = 'https://i2.wp.com/www.theatrecr.org/wp-content/uploads/2016/01/poster-placeholder.png';
        } else {
          posterPath = 'https://image.tmdb.org/t/p/w1280' + movie['poster_path'];
        }

        int releaseYear;
        if (movie['release_date'] == null || movie['release_date'] == '') {
          releaseYear = 0;
        } else {
          releaseYear = int.parse(movie['release_date'].split('-')[0]);
        }

        bestMovies.add(new ShowPreview(movie['id'], posterPath));
        /*
        bestMovies.add(new Show(
          movie['id'],
          movie['original_title'],
          movie['overview'],
          posterPath,
          movie['vote_average'].toString(),
          releaseYear,
          [],
          [],
        ));
        */
      });
    }

    return bestMovies;
  }

  static Future<Show> fetchMovie(int id) async {
    String url = 'https://api.themoviedb.org/3/movie/' + id.toString() + '?api_key=' + API_KEY + '&append_to_response=keywords,credits';

    final response = await http.get(url);
    final movie = jsonDecode(response.body);

    // Poster
    String posterPath;
    if (movie['poster_path'] == null) {
      posterPath = 'https://i2.wp.com/www.theatrecr.org/wp-content/uploads/2016/01/poster-placeholder.png';
    } else {
      posterPath = 'https://image.tmdb.org/t/p/w1280' + movie['poster_path'];
    }

    // Release year
    int releaseYear;
    if (movie['release_date'] == null || movie['release_date'] == '') {
      releaseYear = 0;
    } else {
      releaseYear = int.parse(movie['release_date'].split('-')[0]);
    }

    // Cast
    List<String> castList = [];
    movie['credits']['cast'].forEach((cast) {
      castList.add(cast['name']);
    });

    // Genres
    List<String> genresList = [];
    movie['genres'].forEach((genre) {
      genresList.add(genre['name']);
    });

    // print(genresList);

    return new Show(
      movie['id'],
      movie['original_title'],
      movie['overview'],
      posterPath,
      movie['vote_average'].toString(),
      releaseYear,
      castList,
      genresList,
    );
  }

  static Future<Show> fetchSeries(int id) async {
    String url = 'https://api.themoviedb.org/3/tv/' + id.toString() + '?api_key=' + API_KEY + '&append_to_response=keywords,credits';

    final response = await http.get(url);
    final series = jsonDecode(response.body);

    // Poster
    String posterPath;
    if (series['poster_path'] == null) {
      posterPath = 'https://i2.wp.com/www.theatrecr.org/wp-content/uploads/2016/01/poster-placeholder.png';
    } else {
      posterPath = 'https://image.tmdb.org/t/p/w1280' + series['poster_path'];
    }

    // Cast
    List<String> castList = [];
    series['credits']['cast'].forEach((cast) {
      castList.add(cast['name']);
    });

    // Genres
    List<String> genresList = [];
    series['genres'].forEach((genre) {
      genresList.add(genre['name']);
    });

    print(genresList);

    return new Show(
      series['id'],
      series['original_name'],
      series['overview'],
      posterPath,
      series['vote_average'].toString(),
      int.parse(series['first_air_date'].split('-')[0]),
      castList,
      genresList,
    );
  }
}
