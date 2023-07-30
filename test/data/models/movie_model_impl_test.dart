import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../../mock_data/mock_data.dart';
import '../../network/movie_data_agent_impl_mock.dart';
import '../../persistence/actor_dao_mock.dart';
import '../../persistence/genre_dao_mock.dart';
import '../../persistence/movie_dao_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModelImpl = MovieModelImpl();

    setUp(() {
      movieModelImpl.setDaosAndDataAgent(
        MovieDaoMock(),
        GenreDaoMock(),
        ActorDoaMock(),
        MovieDataAgentImplMock(),
      );
    });

    test(
        "Saving Now Playing Movies and Getting Now Playing Movies From Database",
        () {
      expect(
        movieModelImpl.getNowPlayingMoviesFromDatabase(),
        emits([
          MovieVO(
              false,
              "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
              [16, 12, 10751, 14, 35],
              502356,
              "en",
              "The Super Mario Bros. Movie",
              "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
              6128.924,
              "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
              "2023-04-05",
              "The Super Mario Bros. Movie",
              false,
              7.5,
              1655,
              true,
              false,
              false,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null
              ),
        ]),
      );
    });

    test(
        "Saving Popular Movies and Getting Popular Movies From Database",
            () {
          expect(
            movieModelImpl.getNowPlayingMoviesFromDatabase(),
            emits([
              MovieVO(
                  false,
                  "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
                  [16, 12, 10751, 14, 35],
                  502356,
                  "en",
                  "The Super Mario Bros. Movie",
                  "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                  6128.924,
                  "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                  "2023-04-05",
                  "The Super Mario Bros. Movie",
                  false,
                  7.5,
                  1655,
                  false,
                  true,
                  false,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null,
                  null
              ),
            ]),
          );
        });

    test(
        "Saving Top Rated Movies and Getting Top Rated Movies From Database",
            () {
          expect(
            movieModelImpl.getNowPlayingMoviesFromDatabase(),
            emits([
              MovieVO(
                false,
                "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
                [16, 12, 10751, 14, 35],
                502356,
                "en",
                "The Super Mario Bros. Movie",
                "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                6128.924,
                "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                "2023-04-05",
                "The Super Mario Bros. Movie",
                false,
                7.5,
                1655,
                false,
                false,
                true,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,),
            ]),
          );
        });

    test("Get Genres Test ", () {
      expect(movieModelImpl.getGenres(), completion(equals(getMockGenres())));
    });

    test("Get Actor Test", () {
      expect(movieModelImpl.getActors(1).then((value) => value), completion(equals(getMockActors())));
    });

    test("Get Credits Test", () {
      expect(movieModelImpl.getCreditsByMovie(1).then((value) => value), completion(equals(getMockCredits())));
    });

    test("Get Movie Details Test", () {
      expect(movieModelImpl.getMovieDetails(1), completion(equals(getMockMoviesForTest().first)));
    });

    test("Get Actor From Database Test", () async{
      await movieModelImpl.getActors(1);
      expect(movieModelImpl.getAllActorsFromDatabase().then((value) => value),completion(equals(getMockActors())));
    });

    test("Get Movie Details From Database", () async{
      await movieModelImpl.getMovieDetails(1);
      expect(movieModelImpl.getMovieDetails(1), completion(equals(getMockMoviesForTest().first)));
    });
    
    test("get Genre Form Database", () async{
      await movieModelImpl.getGenres();
      expect(movieModelImpl.getGenresFromDatabase(), completion(equals(getMockGenres())));
    });
    
  });
}
