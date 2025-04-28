import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn({required String email, required String password}) async {
    ApiReturnValue<User> result =
        await UserService.signIn(email: email, password: password);

    if (result.value != null) {
      emit(UserLoaded(user: result.value!));
    } else {
      emit(UserLoadedFailed(message: result.message!));
    }
  }

  Future<void> signUp(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    ApiReturnValue<User> result = await UserService.signUp(
      name: name,
      email: email,
      password: password,
      paswordConfirmation: confirmPassword,
    );

    if (result.value != null) {
      emit(UserLoaded(user: result.value!));
    } else {
      emit(UserLoadedFailed(message: result.message!));
    }
  }

  Future<void> getUserByToken({required String token}) async {
    ApiReturnValue<User> result = await UserService.getUserByToken(token: token);

    if (result.value != null) {
      emit(UserLoaded(user: result.value!));
    } else {
      emit(UserLoadedFailed(message: result.message!));
    }
  }
}
