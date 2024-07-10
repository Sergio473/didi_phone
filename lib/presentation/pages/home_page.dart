import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ddi_phone/domain/usecases/get_user.dart';
import 'package:ddi_phone/infrastructure/data_sources/user_data_source.dart';
import 'package:ddi_phone/infrastructure/repositories/user_repository_impl.dart';
import 'package:ddi_phone/presentation/bloc/user_bloc.dart';
import 'package:ddi_phone/presentation/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Acción de configuración
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => UserBloc(
          GetUser(
            UserRepositoryImpl(
              UserDataSource("https://jsonplaceholder.typicode.com/users"),
            ),
          ),
        ),
        child: const UserPage(),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: 'Load User',
            onPressed: () {
              print("Button pressed"); //Log para probar que el botón funciona correctamente
              final randomId = Random().nextInt(10) + 1; // Genera un ID aleatorio entre 1 y 10
              BlocProvider.of<UserBloc>(context).add(GetUserEvent(randomId.toString()));
            },
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return const Text("Press the button to load user");
              } else if (state is UserLoading) {
                return const CircularProgressIndicator();
              } else if (state is UserLoaded) {
                return Text(
                  "User: ${state.user.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto', // Familia de fuentes
                    letterSpacing: 2.0,
                    fontStyle: FontStyle.italic,
                    /*
                    decoration: TextDecoration.combine([
                      TextDecoration.underline,
                      TextDecoration.lineThrough,
                      ]), */
                  ),
                  );
              } else if (state is UserError) {
                return const Text("Failed to load user");
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
