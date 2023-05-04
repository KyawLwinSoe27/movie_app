import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

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
              null,
              true,
              false,
              false),
        ]),
      );
    });
  });
}
