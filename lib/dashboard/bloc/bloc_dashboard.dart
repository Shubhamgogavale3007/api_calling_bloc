import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:bloc_api_calling/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:bloc_api_calling/dashboard/bloc/event_dashboard.dart';
import 'package:bloc_api_calling/dashboard/bloc/state_dashboard.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    var client = http.Client();

    List<UserModel> mUserModel = [];

    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));




      print(response.body);
      mUserModel = (json.decode(response.body) as List)
          .map((data) => UserModel.fromJson(data))
          .toList();

emit (PostFetchingSuccessfulState(mUserModel));

/*      mUserModel = List<UserModel>.from(
          jsonDecode(response as String).map((model) => UserModel.fromJson(model)));*/
      print(mUserModel.length);


    }
    catch (e) {
      print(e);
    }
  }
}
