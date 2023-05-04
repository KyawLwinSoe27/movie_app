import '../../data/vos/genre_vo.dart';

abstract class GenreDao{
  void saveAllGenre(List<GenreVO> genreList);
  List<GenreVO> getAllGenres();

}