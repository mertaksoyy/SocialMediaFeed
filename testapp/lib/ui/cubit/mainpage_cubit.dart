import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/data/entity/post.dart';
import 'package:testapp/data/repo/socialmediadao_repository.dart';

class MainPageCubit extends Cubit<List<Post>> {
  MainPageCubit() : super(<Post>[]);

  var prepo = SocialMediaDaoRepository();
  Future<void> getPosts() async {
    var list = await prepo.getList();
    //sort by date
    list.sort((a, b) => b.post_date.compareTo(a.post_date));
    emit(list);
  }
}
