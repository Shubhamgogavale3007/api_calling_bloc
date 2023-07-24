import 'package:bloc_api_calling/dashboard/bloc/bloc_dashboard.dart';
import 'package:bloc_api_calling/dashboard/bloc/event_dashboard.dart';
import 'package:bloc_api_calling/dashboard/bloc/state_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PostBloc postBloc = PostBloc();

  @override
  void initState() {
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("API Calling"),
        centerTitle: false,
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is !PostActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;
              return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    print("Hiii");
                    return Column(
                      children: [
                        Text(successState.posts[index].title!),
                        Text(successState.posts[index].id.toString()),
                        Text(successState.posts[index].body.toString()),
                      ],
                    );
                  });
            default :     return const SizedBox();
          }

        },
        listener: (context, state) {},
      ),
    );
  }
}
