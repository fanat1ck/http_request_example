import 'package:flutter/material.dart';
// import 'package:http_request_flutter/domain/api_clients/api_client.dart';
import 'package:http_request_flutter/widgets/example/example_modal.dart';

class ExamplePost extends StatefulWidget {
  const ExamplePost({Key? key}) : super(key: key);

  @override
  State<ExamplePost> createState() => _ExamplePostState();
}

class _ExamplePostState extends State<ExamplePost> {
  final _model = ExampleWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ExampleModelProvider(
        model: _model,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            _ReloadButton(),
            _CreateButton(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _PostsWidget(),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Обновить посты'),
      onPressed: () => ExampleModelProvider.read(context)?.model.reloadPosts(),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Создать пост'),
      onPressed: () => ExampleModelProvider.read(context)?.model.createPosts(),
    );
  }
}

class _PostsWidget extends StatelessWidget {
  const _PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ExampleModelProvider.watch(context)?.model.posts.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _PostRowWidget(index: index);
      },
    );
  }
}

class _PostRowWidget extends StatelessWidget {
  final int index;
  const _PostRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = ExampleModelProvider.read(context)!.model.posts[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.id.toString()),
        const SizedBox(height: 10),
        Text(post.title),
        const SizedBox(height: 10),
        Text(post.body),
        const SizedBox(height: 40)
      ],
    );
  }
}
