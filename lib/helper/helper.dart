import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'package:rapih/cubit/user_cubit.dart';
import 'package:rapih/model/model.dart';
import 'package:url_launcher/url_launcher.dart';

String imageUrl = "http://192.168.0.34:8000/storage";

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

  final DateTime hasil =
      awal.add(Duration(hours: tambahJam, minutes: tambahMenit));

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

String formatCurreny(price) {
  return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
      .format(price);
}

Future<void> sendOrderDetailsViaWhatsapp(
    {required Customer customer, required Order order}) async {
  String text = '''Halo kak ${customer.name} 👋.
  Berikut adalah detail pesanan ${order.orderCode}.
  Tanggal ${DateFormat("EEEE, dd MMMM yyyy HH:mm", 'id_ID').format(DateTime.parse(order.createdAt))}.
  ${order.products!.map((item) => "- ${item.product.name} (${item.quantity}kg/pcs): ${formatCurreny(item.product.price)}")}
  Subtotal: ${formatCurreny(order.products!.fold(0.0, (sum, item) => sum + item.subTotal))}.
  ${order.parfume != null ? "Parfume: ${order.parfume!.name}(${formatCurreny(order.parfume!.price)})." : ""}
  ${order.delivery != null ? "Ongkir: ${order.delivery!.name}(${formatCurreny(order.delivery!.amount)})." : ""}
  ${order.discount != null ? "Discount: -${formatCurreny(order.discount!.amount)}." : ""}
  Total: ${formatCurreny(order.totalPrice)}.
  Pesanan dapat diambil pada: ${DateFormat("EEEE, dd MMMM yyyy HH:mm", 'id_ID').format(DateTime.parse(order.estDate))}.
  Terima kasih telah memesan di toko kami! 🙏
''';

  String encodedText = Uri.encodeComponent(text);
  String androidUrl =
      "whatsapp://send?phone=62${customer.number}&text=$encodedText";
  String iosUrl = "https://wa.me/62${customer.number}?text=$encodedText";
  String webUrl =
      'https://api.whatsapp.com/send/?phone=62${customer.number}&text=$encodedText';

  try {
    final url = Platform.isIOS ? iosUrl : androidUrl;
    final uri = Uri.parse(url);

    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri);
    } else {
      final webUri = Uri.parse(webUrl);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } else {
        print("Tidak bisa membuka WhatsApp atau fallback web.");
      }
    }
  } catch (e) {
    final webUri = Uri.parse(webUrl);
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } else {
      print("Gagal membuka semua URL: $e");
    }
  }
}

Future<String> generateInvoiceText({
  required String title,
  required Order order,
}) async {
  print(order);
  final df = DateFormat("dd MMM yyyy HH:mm", 'id_ID');
  final buffer = StringBuffer();

  buffer.writeln(centerText(title.toUpperCase()));
  buffer.writeln("--------------------------------");

  buffer.writeln("Kode     : ${order.orderCode}");
  buffer.writeln("Tanggal  : ${df.format(DateTime.parse(order.createdAt))}");
  buffer.writeln("Selesai  : ${df.format(DateTime.parse(order.estDate))}");
  buffer.writeln("--------------------------------");

  buffer.writeln("Pelanggan: ${order.customer.name}");
  buffer.writeln("Alamat   : ${order.customer.address}");
  buffer.writeln("No. HP   : 0${order.customer.number}");
  buffer.writeln("--------------------------------");

  buffer.writeln("Kasir     : ${order.cashierName}");
  buffer.writeln("Pembayaran: ${order.paymentMethod}");
  buffer.writeln("Layanan   : ${order.layanan!.name}");
  buffer.writeln("--------------------------------");

  buffer.writeln("Item              Qty   Harga");
  for (var item in order.products!) {
    buffer.writeln("${item.product.name.padRight(16).substring(0, 16)}"
        "${item.quantity.toString().padLeft(3)}x "
        "${formatRupiah(item.product.price)}");
  }

  buffer.writeln("--------------------------------");

  buffer.writeln("Subtotal      : ${formatRupiah(
    order.products!.fold(0.0, (sum, item) => sum + item.subTotal),
  )}");

  if (order.parfume != null) {
    buffer.writeln("Parfume       : ${formatRupiah(order.parfume!.price)}");
  }

  if (order.delivery != null) {
    buffer.writeln("Ongkir        : ${formatRupiah(order.delivery!.amount)}");
  }

  if (order.discount != null) {
    buffer.writeln("Diskon        : -${formatRupiah(order.discount!.amount)}");
  }

  buffer.writeln("--------------------------------");
  buffer.writeln("TOTAL         : ${formatRupiah(order.totalPrice)}");
  buffer.writeln("--------------------------------");

  buffer.writeln(centerText("Terima kasih!"));

  return buffer.toString();
}

String formatRupiah(amount) {
  return "Rp${amount.toInt().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      )}";
}

String centerText(String text, [int width = 32]) {
  final pad = ((width - text.length) / 2).floor();
  return ' ' * pad + text;
}

Future<List<int>> generateInvoice({
  required String title,
  required Order order,
}) async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];

  bytes += generator.text(title,
      styles: PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));
  bytes += generator.hr();

  final df = DateFormat("dd MMM yyyy HH:mm", 'id_ID');
  bytes += generator.text("Kode: ${order.orderCode}");
  bytes +=
      generator.text("Tanggal: ${df.format(DateTime.parse(order.createdAt))}");
  bytes += generator.hr();

  for (var item in order.products!) {
    bytes += generator.row([
      PosColumn(text: item.product.name, width: 6),
      PosColumn(
          text: "${item.quantity}x",
          width: 2,
          styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: "Rp${item.product.price.toInt()}",
          width: 4,
          styles: PosStyles(align: PosAlign.right)),
    ]);
  }

  bytes += generator.hr();

  bytes += generator.row([
    PosColumn(text: 'Subtotal', width: 8),
    PosColumn(
        text:
            "Rp${order.products!.fold(0.0, (sum, item) => sum + item.subTotal).toInt()}",
        width: 4,
        styles: PosStyles(align: PosAlign.right)),
  ]);

  if (order.parfume != null) {
    bytes += generator.row([
      PosColumn(text: 'Parfume', width: 8),
      PosColumn(
          text: "Rp${order.parfume!.price.toInt()}",
          width: 4,
          styles: PosStyles(align: PosAlign.right)),
    ]);
  }

  if (order.delivery != null) {
    bytes += generator.row([
      PosColumn(text: 'Ongkir', width: 8),
      PosColumn(
          text: "Rp${order.delivery!.amount.toInt()}",
          width: 4,
          styles: PosStyles(align: PosAlign.right)),
    ]);
  }

  if (order.discount != null) {
    bytes += generator.row([
      PosColumn(text: 'Diskon', width: 8),
      PosColumn(
          text: "-Rp${order.discount!.amount.toInt()}",
          width: 4,
          styles: PosStyles(align: PosAlign.right)),
    ]);
  }

  bytes += generator.hr();
  bytes += generator.row([
    PosColumn(
        text: 'Total',
        width: 8,
        styles: PosStyles(bold: true, align: PosAlign.left)),
    PosColumn(
        text: "Rp${order.totalPrice.toInt()}",
        width: 4,
        styles: PosStyles(bold: true, align: PosAlign.right)),
  ]);

  bytes += generator.feed(1);
  bytes += generator.text("Terima kasih!",
      styles: PosStyles(align: PosAlign.center, bold: true));
  bytes += generator.feed(2);
  bytes += generator.cut();

  return bytes;
}
