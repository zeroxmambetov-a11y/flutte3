import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cat_bloc.dart';

class CatScreen extends StatelessWidget {
  const CatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Кошки')),
        body: BlocBuilder<CatBloc, dynamic>(
          builder: (context, state) {
            if (state is CatLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CatErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is CatLoadedState) {
              return ListView.builder(
                itemCount: state.cats.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      state.cats[index].url,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }

            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<CatBloc>().add(GetCatsEvent());
                },
                child: const Text('Загрузить котов'),
              ),
            );
          },
        ),
      ),
    );
  }
}
