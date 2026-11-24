import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cat_bloc.dart';
import '../bloc/cat_event.dart';
import '../bloc/cat_state.dart';

class CatScreen extends StatelessWidget {
  const CatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кошки')),
      body: Center(
        child: BlocBuilder<CatBloc, CatState>(
          builder: (context, state) {
            if (state is CatLoadingState) {
              return const CircularProgressIndicator();
            }

            if (state is CatErrorState) {
              return Text(
                state.message,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              );
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

          
            return ElevatedButton(
              onPressed: () {
                context.read<CatBloc>().add(LoadCatsEvent());
              },
              child: const Text('Загрузить котов'),
            );
          },
        ),
      ),
    );
  }
}
