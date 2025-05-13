part of 'absence_cubit.dart';

sealed class AbsenceState extends Equatable {
  const AbsenceState();

  @override
  List<Object> get props => [];
}

final class AbsenceInitial extends AbsenceState {}

final class AbsenceLoaded extends AbsenceState {
  final Absence absence;

  const AbsenceLoaded(this.absence);

  @override
  List<Object> get props => [absence];
}

final class AbsenceLoadedFailed extends AbsenceState {
  final String message;

  const AbsenceLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}
