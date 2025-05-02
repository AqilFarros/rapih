import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'layanan_state.dart';

class LayananCubit extends Cubit<LayananState> {
  LayananCubit() : super(LayananInitial());
}
