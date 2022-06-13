import 'dart:convert';
import 'dart:io';

import 'package:http_request_flutter/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();
  Future<List<Post>> getPost() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;
    final post =
        json.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    return post;
  }

  Future<Post?> createPost(
      {required String title, required String body}) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parametrs = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 103,
    };

    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parametrs));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
  }
}
