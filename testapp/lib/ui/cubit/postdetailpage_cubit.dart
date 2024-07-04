import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/data/repo/socialmediadao_repository.dart';

class PostDetailCubit extends Cubit<void> {
  PostDetailCubit() : super(0);

  var prepo = SocialMediaDaoRepository();

  Future<void> getPost(int postId, String postDate, String postHeadertext,
      String postBodytext, File? image) async {
    await prepo.getPost(postId, postDate, postHeadertext, postBodytext, image);
  }
}
