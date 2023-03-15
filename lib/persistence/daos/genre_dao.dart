import 'package:hive/hive.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import '../../data/vos/genre_vo.dart';

class GenreDao {

  static final GenreDao _singleton = GenreDao._internal();

  factory GenreDao() {
    return _singleton;
  }

  GenreDao._internal();

  void saveAllGenre(List<GenreVO> genreList) async {
    Map<int,GenreVO> genreMap = Map.fromIterable(genreList, key: (genre) => genre.id, value: (genre) => genre);
    return await getGenreBox().putAll(genreMap);
  }

  List<GenreVO> getAllGenres() {
    return getGenreBox().values.toList();
  }

  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }
}