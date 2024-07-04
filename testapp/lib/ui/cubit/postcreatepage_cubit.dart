import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/data/repo/socialmediadao_repository.dart';

class PostCreateCubit extends Cubit<void> {
  PostCreateCubit() : super(0);

  var prepo = SocialMediaDaoRepository();

  Future<void> createPost(String postDate, String postHeadertext,
      String postBodytext, File? image) async {
    await prepo.createPost(postDate, postHeadertext, postBodytext, image);
  }
}
