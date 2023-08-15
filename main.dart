import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as web show runApp;
import 'package:flutter/material.dart' as mobile show runApp;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toprun_application/core/config/amplifyconfiguration.dart';
import 'package:toprun_application/core/controller/my_isolates.dart';
import 'package:toprun_application/screens/actors/shipper/shipperAccountingScreen.dart';
import 'package:toprun_application/screens/actors/transporter/transporterAccountingScreen.dart';

import '/utilities/strDictionary.dart';
import 'core/controller/state/log/log_notifier.dart';
import 'features/account/presentation/screens/account/account_screen.dart';
import 'features/account/presentation/screens/credit/credit_screen.dart';
import 'features/login/login.dart';
import 'features/login/screens/login_screen.dart';
import 'features/package/presentation/screen/image_list_screen.dart';
// import 'features/package/presentation/screen/package_screen.dart';
import 'features/package/presentation/screen/package_screen_shipper.dart';
import 'screens/actors/screens.dart';
import 'testing_screen.dart';
import '/features/google_maps/data/models/location_service.dart';

// Global Variable for AppBar Admin Mode
bool isAdmin = false;

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000004),
    700: Color(0xFF000003),
    800: Color(0xFF000002),
    900: Color(0xFF000001),
  },
);
const int _blackPrimaryValue = 0xFF000000;

Future<void> main() async {
  // if the app is running on mobile, run the mobile version of the app
  // To ensure that the binding is initialized, call the ensureInitialized() method before calling runApp().
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the service locator, then initialize the ControllerInstance singleton
  // await prod.setupLocator().then((value) => ControllerInstance());
  // Unless you are using the previous controller, do not initialize the ControllerInstance singleton
  // outside of the ProviderScope widget. Otherwise, the isolates will not be able to access the provider.
  // ControllerInstance();
  // if the app is running on the web, run the web version of the app
  if (kIsWeb) {
    // Use the ProviderScope widget to provide the same instance of the controller to all the widgets
    web.runApp(const ProviderScope(child: MyApp()));
  } else {
    // if the app is running on mobile, run the mobile version of the app
    mobile.runApp(const ProviderScope(child: MyApp()));
  }
  // runApp(const ProviderScope(child: MyApp()));
}

// MyApp will extend ConsumerStatefulWidget to use the ProviderScope widget
class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // initialize the amplify plugin (only called once)
    _configureAmplify();
    _initializeController();
    // initialize the ControllerInstance singleton
    // final controllerStateNotifier = ref.read(controllerStateProvider.notifier);
    // controllerStateNotifier.initialize();
    LocationService.enableLocation();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> _initializeController() async {
    ControllerInstance();
    // final isolate = await spawnBlocController();
    // ControllerInstance().blocController = isolate;
    Future.delayed(Duration(seconds: 2), () {
      ref.read(logStateProvider.notifier).logBlocController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      // home: const LoginScreen(),

      initialRoute: loginRoute,
      // initialRoute: useCasesRoute,
      routes: {
        useCasesRoute: (context) => const UseCasesScreen(),
        consoleRoute: (context) => ConsoleScreen(),
        loginRoute: (context) => const LoginScreen(),
        accountRoute: (context) => const AccountScreen(),
        creditRoute: (context) => const CreditScreen(),
        dispatcherRoute: (context) => const DispatcherScreen(),
        employeeRoute: (context) => const Employee(),
        shipperRoute: (context) => const ShipperSplashScreen(),
        shipperHome: (context) => const ShipperDeliveryStatusScreen(),
        shipperAccountingRoute: (context) => const ShipperAccountingScreen(),
        transporterHome: (context) => const TransporterHome(),
        transporterRoute: (context) => const SplashScreen(),
        transporterAccountingRoute: (context) =>
            const TransporterAccountingScreen(),
        // PackageScreen.routeName: (_) => PackageScreen('', ''),
        PackageScreenShipper.routeName: (_) =>
            PackageScreenShipper('', '', '', '', false),
        ImageListScreen.routeName: (_) => ImageListScreen('', '', const []),
        // linkEmployeeRoute: (context) => LinkEmployee(),
      },
    );
  }
}
