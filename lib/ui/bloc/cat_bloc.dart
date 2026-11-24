import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/cat_repository.dart';
import 'cat_event.dart';
import 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository _repository = CatRepository();

  CatBloc() : super(CatInitialState()) {
    on<LoadCatsEvent>((event, emit) async {
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
