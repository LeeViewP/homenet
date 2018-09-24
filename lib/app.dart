import 'package:flutter/material.dart';
import './views/splash.dart';
import './views/dashboardview.dart';
import './views/sensorsView.dart';
import './views/settingsview.dart';
import './views/homeview.dart';
// import './sensorsModelsView.dart';

class HomeNet extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return new MaterialApp(
			title: 'homeNet.ai',
			theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        //  brightness: Brightness.dark,
        primarySwatch: Colors.green,
        accentColor: Colors.redAccent,
        
				primaryTextTheme: const TextTheme(
					headline: const TextStyle(
						color: Colors.white
					)
				)
			),
      // home:new Splash(),
			initialRoute: '/',
      routes: <String, WidgetBuilder> {
        HomeView.routeName:  (BuildContext context) => new HomeView(),
        DashboardView.routeName: (BuildContext context) => new DashboardView(),
        SensorsView.routeName: (BuildContext context) => new SensorsView(),
        SettingsView.routeName: (BuildContext context) => new SettingsView(),
        // "/":(BuildContext context) => new Splash(),
        // SensorsViewModel.routeName:(BuildContext context)=>new SensorsViewModel(),
        // SensorDetails.routeName: (BuildContext context)=> new SensorDetails(),
			}
		);
	}
	
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation, 
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}