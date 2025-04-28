part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoaded extends UserState {
  final User user;

  const UserLoaded({required this.user});

  @override
  List<Object> get props => [];
}

final class UserLoadedFailed extends UserState {
  final String message;

  const UserLoadedFailed({required this.message});

  @override
  List<Object> get props => [];
}
