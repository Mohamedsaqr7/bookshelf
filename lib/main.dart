import 'package:bloc/bloc.dart';
import 'package:bookshelf/Features/Authentications/ViewModel/authcubit.dart';
import 'package:bookshelf/Features/home/view/screens/homepage.dart';
import 'package:bookshelf/Features/home/viewmodel/homepagecubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Core/Services/Network/Diohelper.dart';
import 'Core/Services/bloc_observer.dart';
import 'Core/Services/local/Secure_storagee.dart';
import 'Core/Services/local/sharedpref/shared.dart';
import 'Features/Authentications/View/Register.dart';
import 'Features/Authentications/View/login.dart';
import 'Features/home/view/layouts/books.dart';
import 'Features/home/view/screens/bestsellerscreen.dart';
import 'Features/home/view/screens/bookscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.initState();
  String? token = await SecureStorage().storage.read(key: 'token');

  Bloc.observer = MyBlocObserver();
  Widget? widget;
  if (token != null) {
    widget = HomePage();
  } else {
    widget = HomePage();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(
              create: (context) => HomePageCubit()
                ..bestseller()
                ..getcategory()
                ..getbook()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: startWidget);
          },
        ));
  }
}
