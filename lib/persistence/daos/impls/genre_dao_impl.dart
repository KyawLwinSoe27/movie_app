import 'package:hive/hive.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import '../../../data/vos/genre_vo.dart';
import '../genre_dao.dart';


class GenreDaoImpl extends GenreDao{

  static final GenreDaoImpl _singleton = GenreDaoImpl._internal();

  factory GenreDaoImpl() {
    return _singleton;
  }

  GenreDaoImpl._internal();

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