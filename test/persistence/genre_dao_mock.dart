import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';

class GenreDaoMock extends GenreDao {
  Map<int,GenreVO> genreListFromDatabaseMock = {};
  @override
  List<GenreVO> getAllGenres() {
    return genreListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllGenre(List<GenreVO> genreList) {
    return genreList.forEach((genre) {
      genreListFromDatabaseMock[genre.id ?? 0] = genre;
    });
  }

}