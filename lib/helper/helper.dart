import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapih/cubit/user_cubit.dart';

String imageUrl = "http://192.168.0.27:8000/storage";

String roleNavigation(BuildContext context) {
  final role = ((context.read<UserCubit>()).state as UserLoaded).user.role;

  if (role == "admin") {
    return '/admin';
  } else if (role == "owner") {
    return '/owner';
  } else if (role == 'cashier') {
    return '/cashier';
  } else {
    return '/unpaid';
  }
}
