import 'package:flutter_bloc/flutter_bloc.dart';
import 'cat_model.dart';
import 'cat_repository.dart';


class GetCatsEvent {}


class CatInitialState {}

class CatLoadingState {}

class CatLoadedState {
  final List<CatModel> cats;
  CatLoadedState(this.cats);
}

class CatErrorState {
  final String message;
  CatErrorState(this.message);
}


class CatBloc extends Bloc<GetCatsEvent, dynamic> {
  final CatRepository _repository = CatRepository();

  CatBloc() : super(CatInitialState()) {
    on<GetCatsEvent>((event, emit) async {
      emit(CatLoadingState());
      try {
        final cats = await _repository.getCats();
        emit(CatLoadedState(cats));
      } catch (e) {
        emit(CatErrorState('Ошибка: $e'));
      }
    });
  }
}
