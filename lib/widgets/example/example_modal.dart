import 'package:flutter/cupertino.dart';
import 'package:http_request_flutter/domain/api_clients/api_client.dart';
import 'package:http_request_flutter/domain/entity/post.dart';

class ExampleWidgetModel extends ChangeNotifier {
  final apiCLient = ApiClient();
  var _posts = <Post>[];
  List<Post> get posts => _posts;

  Future<void> reloadPosts() async {
    final post = await apiCLient.getPost();
    _posts += post;
    notifyListeners();
  }

  Future<void>? createPosts() async {
    final post = await apiCLient.createPost(title: 'Fornitche', body: 'Table');
  }
}

class ExampleModelProvider extends InheritedNotifier {
  final ExampleWidgetModel model;

  const ExampleModelProvider(
      {Key? key, required Widget child, required this.model})
      : super(child: child, key: key, notifier: model);

  static ExampleModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }

  static ExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;

    return widget is ExampleModelProvider ? widget : null;
  }
}
