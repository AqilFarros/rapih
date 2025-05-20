import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rapih/cubit/user_cubit.dart';
import 'package:rapih/model/model.dart';

String imageUrl = "http://192.168.0.29:8000/storage";

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

String formatWaktuDenganPenambahan({
  DateTime? waktuAwal,
  int tambahJam = 0,
  int tambahMenit = 0,
}) {
  final DateTime awal = waktuAwal ?? DateTime.now();

  final DateTime hasil = awal.add(Duration(hours: tambahJam, minutes: tambahMenit));

  final hari = DateFormat('EEEE', 'id').format(hasil);
  final tanggal = DateFormat('d MMMM yyyy', 'id').format(hasil);
  final jamMenit = DateFormat('HH.mm').format(hasil);

  return '$hari, $tanggal pukul $jamMenit';
}

double calculateTotalPrice(List<SelectedProduct> selectedProducts) {
  return selectedProducts.fold(
    0,
    (total, item) => total + (item.product.price * item.quantity).toDouble(),
  );
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
