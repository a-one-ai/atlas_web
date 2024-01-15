import '../app_export.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
      routeInformationParser: AppRoutes.goRouter.routeInformationParser,
      routerDelegate: AppRoutes.goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),

      scaffoldMessengerKey: globalMessengerKey,
      //for setting localization strings
      supportedLocales: const [
        Locale('en'),
        // Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Atlas',
    );
  }
}
