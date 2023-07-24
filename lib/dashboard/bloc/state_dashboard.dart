import '../../model/model.dart';

abstract class PostState{}

class PostInitial extends PostState{}


class PostFetchingSuccessfulState extends PostState{
final List<UserModel> posts;

  PostFetchingSuccessfulState(this.posts);

}


abstract class PostActionState extends PostState{}
