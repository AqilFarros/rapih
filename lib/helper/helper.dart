import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rapih/cubit/user_cubit.dart';

String imageUrl = "http://192.168.0.28:8000/storage";

String roleNavigation(BuildContext context) {
  final role = ((context.read<UserCubit>()).state as UserLoaded).user.role;

  if (role == "admin") {
    return '/admin';
  } else if (role == "owner") {
    return '/owner';
  } else if (role == 'kasir') {
    return '/cashier';
  } else {
    return '/unpaid';
  }
}

String convertToHourMinute(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  return DateFormat.Hm().format(dateTime);
}

String formatDate(String isoString) {
  final dateTime = DateTime.parse(isoString);
  return DateFormat('dd MMM').format(dateTime);
}

String formatDateMonthYear(String isoString) {
  final dateTime = DateTime.parse(isoString);
  return DateFormat('dd MMM yyyy').format(dateTime);
}
