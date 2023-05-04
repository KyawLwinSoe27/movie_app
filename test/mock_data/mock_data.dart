import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

List<MovieVO> getMockMoviesForTest() {
  return [
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
        false,
        true,
        false),
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
        false,
        false,
        true),
  ];
}

List<ActorVO> getMockActors() {
  return [
    ActorVO(false, 1104321, [], "Scott Ly", 281.794, "/3AzHImm0oz2xV5mekONhl2zYXVU.jpg",
        "Acting", "Scott Ly", null, null, null, null),
    ActorVO(false, 224513, [], "Ana de Armas", 275.648, "/3vxvsmYLTf4jnr163SUlBIw51ee.jpg",
        "Acting", "Ana de Armas", null, null, null, null),
    ActorVO(false, 2710789, [], "Seung Ha", 201.455, "/hpMpnHprRlCzvNVlx6C3RWmswOF.jpg",
        "Acting", "Seung Ha", null, null, null, null),

  ];
}

List<GenreVO> getMockGenres() {
  return [
    GenreVO(1, "Action"),
    GenreVO(2, "Adventure"),
    GenreVO(3, "Comedy")
  ];
}

List<ActorVO> getMockCredits() {
  return [
    ActorVO(false, 58021, [], "Tinto Brass", 229.223, "/adQ1j2FQ1FZ67hlZVhsUnALM4G4.jpg",
        "Directing", "Tinto Brass", null, null, null, null),
    ActorVO(false, 224513, [], "Ana de Armas", 275.648, "/3vxvsmYLTf4jnr163SUlBIw51ee.jpg",
        "Acting", "Ana de Armas", null, null, null, null),
    ActorVO(false, 2710789, [], "Seung Ha", 201.455, "/hpMpnHprRlCzvNVlx6C3RWmswOF.jpg",
        "Acting", "Seung Ha", null, null, null, null),
  ];
}