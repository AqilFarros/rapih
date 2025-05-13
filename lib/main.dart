import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapih/cubit/absence_cubit.dart';
import 'package:rapih/cubit/cashier_cubit.dart';
import 'package:rapih/cubit/category_cubit.dart';
import 'package:rapih/cubit/customer_cubit.dart';
import 'package:rapih/cubit/delivery_cubit.dart';
import 'package:rapih/cubit/discount_cubit.dart';
import 'package:rapih/cubit/laundry_cubit.dart';
import 'package:rapih/cubit/layanan_cubit.dart';
import 'package:rapih/cubit/parfume_cubit.dart';
import 'package:rapih/cubit/product_cubit.dart';
import 'package:rapih/cubit/user_cubit.dart';
import 'package:rapih/cubit/wallet_cubit.dart';
import 'package:rapih/ui/page/page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => LaundryCubit()),
        BlocProvider(create: (context) => WalletCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => CustomerCubit()),
        BlocProvider(create: (context) => DeliveryCubit()),
        BlocProvider(create: (context) => DiscountCubit()),
        BlocProvider(create: (context) => LayananCubit()),
        BlocProvider(create: (context) => ParfumeCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => CashierCubit()),
        BlocProvider(create: (context) => AbsenceCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/boarding': (context) => const OnboardingPage(),
          '/auth': (context) => const AuthenthicationPage(),
          '/home': (context) => const HomePage(),
          '/admin': (context) => const AdminHomePage(),
          '/owner': (context) => const OwnerHomePage(),
          '/cashier': (context) => const CashierHomePage(),
          '/unpaid': (context) => const UnpaidHomePage(),
          '/create-laundry': (context) => const CreateLaundryPage(),
          '/profile': (context) => const ProfilePage(),
        },
      ),
    );
  }
}
