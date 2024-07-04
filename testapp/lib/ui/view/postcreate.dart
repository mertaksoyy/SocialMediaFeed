import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // For Date package
import 'package:image_picker/image_picker.dart';
import 'package:testapp/ui/cubit/postcreatepage_cubit.dart';
import 'package:testapp/ui/view/mainpage.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  TextEditingController tfHeaderText = TextEditingController();
  TextEditingController tfBodyText = TextEditingController();
  File? _image;

  // Photo selection function
  void _chooseImage(ImageSource source) async {
    final selectedPhoto = await _picker.pickImage(source: source);
    setState(() {
      if (selectedPhoto != null) {
        _image = File(selectedPhoto.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Create Page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Today Date is : $todayDate',
                  style: const TextStyle(fontSize: 20),
                ),
                TextFormField(
                  controller: tfHeaderText,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Header Text",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter header text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: tfBodyText,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Body Text",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter body text';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _chooseImage(ImageSource.gallery);
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child:
                            _image == null ? const Text('Choose Photo') : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (tfBodyText.text.isEmpty || tfHeaderText.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter a value")));
          } else {
            context.read<PostCreateCubit>().createPost(
                todayDate, tfHeaderText.text, tfBodyText.text, _image);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          }
          /*if (_formKey.currentState!.validate()) {
            context.read<PostCreateCubit>().createPost(
                  todayDate,
                  tfHeaderText.text,
                  tfBodyText.text,
                  _image,
                );
          }*/
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
