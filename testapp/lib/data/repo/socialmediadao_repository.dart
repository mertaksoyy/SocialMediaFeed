import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:testapp/data/entity/post.dart';
import 'package:testapp/sqlite/dbHelper.dart';
import 'package:path_provider/path_provider.dart';

class SocialMediaDaoRepository {
  // Create Post
  Future<void> createPost(String postDate, String postHeadertext,
      String postBodytext, File? image) async {
    var db = await dbHelper.dbAccess();
    var newPost = Map<String, dynamic>();
    newPost["post_date"] = postDate;
    newPost["post_headerText"] = postHeadertext;
    newPost["post_bodyText"] = postBodytext;

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final fileName = image.path.split('/').last;
      final newImage = await image.copy('$path/$fileName');
      newPost["imagePath"] = newImage.path;
    }

    await db.insert("post", newPost);
  }

  // Get post for Detail
  Future<void> getPost(int postId, String postDate, String postHeadertext,
      String postBodytext, File? image) async {
    print(
        " Post :$postDate - $postHeadertext,$postBodytext,Image :${image?.path}");
  }

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  // Main Page Lists
  Future<List<Post>> getList() async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    var db = await dbHelper.dbAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM post");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      return Post(
          post_id: row["post_id"],
          post_date: formatter.parse(row["post_date"]),
          post_headerText: row["post_headerText"],
          post_bodyText: row["post_bodyText"],
          imagePath: row["imagePath"]);
    });
  }
}
