import 'package:hive/hive.dart';

import '../../../data/vos/actor_vo.dart';
import '../../hive_constants.dart';
import '../actor_dao.dart';

class ActorDaoImpl extends ActorDao {

  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl(){
    return _singleton;
  }

  ActorDaoImpl._internal();

  @override
  void saveAllActors(List<ActorVO> actorList) async {
    Map<int,ActorVO> actorMap = { for (var actor in actorList) actor.id ?? 0 : actor };
    return await getActorBox().putAll(actorMap);
  }

  @override
  List<ActorVO> getAllActors() {
    return getActorBox().values.toList();
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

}