import 'package:application/bloc/network_cubit.dart';
import 'package:application/bloc/network_services.dart';
import 'package:application/controller/randomuser_provider.dart';
import 'package:application/l10n/l1on.dart';
import 'package:application/l10n/localization.dart';
import 'package:application/resources/route_manager.dart';
import 'package:application/services/local_provider.dart';
import 'package:application/ui/screens/splash/splash_screeen.dart';
import 'package:application/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc/src/multi_bloc_provider.dart';
//import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Locale? locale;
  // Local to set the local language to the application
  @override
  void initState() {
    super.initState();
    UserPreferences.getLocaleLanguageCode().then((value) => {
          setState(() {
            LocaleProvider().setLocale(locale = Locale(value));
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    var networkService = NetworkService();

    return MultiBlocProvider(
        providers: [
          BlocProvider<NetworkCubit>(
            create: (context) =>
                NetworkCubit(networkService: networkService, context: context),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<RandomUserProvider>(create: (_) => RandomUserProvider()),
          ],
          child: ChangeNotifierProvider(
            create: (_) => LocaleProvider(),
            child: Consumer<LocaleProvider>(
              builder: (context, model, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  onGenerateTitle: (context) =>
                      AppLocalizations.of(context)!.appName,
                  locale: model.locale ?? locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: L10n.all,
                  initialRoute: SplashScreen.id,
                  routes: routes,
                  home: SplashScreen(),
                );
              },
            ),
          ),
        ));

    // return ChangeNotifierProvider(
    //   create: (_) => LocaleProvider(),
    //   child: Consumer<LocaleProvider>(
    //     builder: (context, model, child) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         onGenerateTitle: (context) =>
    //             AppLocalizations.of(context)!.appName,
    //         locale: model.locale ?? locale,
    //         localizationsDelegates: const [
    //           AppLocalizations.delegate,
    //           GlobalMaterialLocalizations.delegate,
    //           GlobalCupertinoLocalizations.delegate,
    //           GlobalWidgetsLocalizations.delegate,
    //         ],
    //         supportedLocales: L10n.all,
    //         initialRoute: SplashScreen.id,
    //         routes: routes,
    //         home: SplashScreen(),
    //       );
    //     },
    //   ),
    // );

    //MultiBlocProvider();
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   //localizationsDelegates: AppLocalizations.localizationsDelegates,
    //   localizationsDelegates: const [
    //    // AppLocalizations.delegate,
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //     GlobalCupertinoLocalizations.delegate,
    //   ],
    //   supportedLocales: L10n.all,

    //   // localizationsDelegates: const [
    //   //   AppLocalizations.delegate,
    //   //   GlobalMaterialLocalizations.delegate,
    //   //   GlobalCupertinoLocalizations.delegate,
    //   //   GlobalWidgetsLocalizations.delegate,
    //   // ],
    //   //supportedLocales: L10n.all,
    //   initialRoute: SplashScreen.id,
    //   routes: routes,

    //   home: const SplashScreen(),
    // );
  }
}
