import '../../data/models/cat_model.dart';

sealed class CatState {}

final class CatInitialState extends CatState {}

final class CatLoadingState extends CatState {}

final class CatLoadedState extends CatState {
  final List<CatModel> cats;
  CatLoadedState(this.cats);
}

final class CatErrorState extends CatState {
  final String message;
  CatErrorState(this.message);
}

