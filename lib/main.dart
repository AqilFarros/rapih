import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapih/cubit/laundry_cubit.dart';
import 'package:rapih/cubit/user_cubit.dart';
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
          '/subscribe': (context) => const SubscribePage(),
          '/create-laundry': (context) => const CreateLaundryPage(),
          '/laundry': (context) => const LaundryPage(),
        },
      ),
    );
  }
}
