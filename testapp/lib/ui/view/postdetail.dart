import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testapp/data/entity/post.dart';

class PostDetailPage extends StatefulWidget {
  Post post;
  PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  TextEditingController tfHeaderText = TextEditingController();
  TextEditingController tfBodyText = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    var post = widget.post;
    todayDate = DateFormat('dd-MM-yyyy').format(post.post_date);
    tfHeaderText.text = post.post_headerText;
    tfBodyText.text = post.post_bodyText;
    if (post.imagePath != null) {
      _image = File(post.imagePath!);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Today Date is : ${todayDate}',
                style: const TextStyle(fontSize: 20),
              ),
              TextFormField(
                readOnly: true,
                controller: tfHeaderText,
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Header Text",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              TextFormField(
                readOnly: true,
                controller: tfBodyText,
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Body Text",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: _image != null ? FileImage(_image!) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
