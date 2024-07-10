import 'package:ddi_phone/domain/usecases/get_user.dart';
import 'package:equatable/equatable.dart';
import 'package:ddi_phone/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;

  UserBloc(this.getUser) : super(UserInitial()){
    on<GetUserEvent>(_onGetUserEvent);
  }

  Future<void> _onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    print('Loading User with ID: ${event.id}');  // Log para verificar el evento

    try {
      final user = await getUser(event.id);
      print('User Loaded: ${user.name}');  // Log para verificar la carga del usuario
      emit(UserLoaded(user: user));
    } catch (e) {
      print('Error loading user: $e');  // Log para verificar errores
      emit(UserError());
    }
  }
}

