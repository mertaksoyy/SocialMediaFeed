import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:testapp/data/entity/post.dart';
import 'package:testapp/ui/cubit/mainpage_cubit.dart';
import 'package:testapp/ui/view/postcreate.dart';
import 'package:testapp/ui/view/postdetail.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<MainPageCubit>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TimeLine")),
      body: BlocBuilder<MainPageCubit, List<Post>>(
        builder: (context, postList) {
          if (postList.isNotEmpty) {
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                var post = postList[index];
                String myDate = DateFormat('dd-MM-yyyy').format(post.post_date);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostDetailPage(post: post)));
                  },
                  child: Card(
                      child: SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(myDate),
                            Text(post.post_headerText),
                            Text(post.post_bodyText),
                          ],
                        ),
                        CircleAvatar(
                            radius: 40,
                            backgroundImage: post.imagePath != null
                                ? FileImage(File(post.imagePath!))
                                : null)
                      ],
                    ),
                  )),
                );
              },
            );
          } else {
            return const Center(child: Text("No posts available"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PostCreatePage())).then((value) {
            context.read<MainPageCubit>().getPosts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
