import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:liro/data/shared_preferences/shared_preferences.dart';
import 'package:liro/repositories/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(loginUserEvent);
  }

  FutureOr<void> loginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    final userData = {'username': event.username, 'password': event.password};
    emit(LoginLoadingState());
    final response = await LoginRepo().loginUser(userData);
    if (response.data['token'] != null) {
      storeData(response.data);
      emit(LoginSuccessState(message: response.data['message']));
    } else {
      emit(LoginFailureState(message: response.data['message']));
    }
  }

  storeData(response) async {
    SharedPref.instance.sharedPref
        .setString(SharedPref.userId, response['userId']);
    SharedPref.instance.sharedPref
        .setString(SharedPref.userName, response['user']);
    SharedPref.instance.sharedPref
        .setString(SharedPref.accessToken, response['token']);

  
  }
}
