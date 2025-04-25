import 'package:flutter/material.dart';
import 'package:responsive_theme/responsive_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: MyApp(),
    ),
  );
}

/// First, create your color configurations:
/// Make lib/config/theme/app_colors.dart file for this
class AppColors {
  final Color background;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color error;
  final Color success;

  /// add other as per you need. make sure to add new properties in toThemeColor() and ThemeColorKey extension

  const AppColors({
    required this.background,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.error,
    required this.success,
  });

  /// Important for responsive_theme
  ThemeColor toThemeColor() {
    return {
      'background': background,
      'primary': primary,
      'secondary': secondary,
      'accent': accent,
      'error': error,
      'success': success,
    };
  }

  // Colors for light theme
  factory AppColors.light() => AppColors(
        background: Color(0xFFFFFFFF),
        primary: Color(0xFF6200EE),
        secondary: Color(0xFF03DAC6),
        accent: Color(0xFF3700B3),
        error: Color(0xFFB00020),
        success: Color(0xFF4CAF50),
      );

  // Colors for dark theme
  factory AppColors.dark() => AppColors(
        background: Color(0xFF121212),
        primary: Color(0xFFBB86FC),
        secondary: Color(0xFF03DAC6),
        accent: Color(0xFF03DAC5),
        error: Color(0xFFCF6679),
        success: Color(0xFF4CAF50),
      );
}

/// this extention make easy to access colors
extension ThemeColorKey on ThemeColor {
  Color get background => this['background']!;

  Color get primary => this['primary']!;

  Color get secondary => this['secondary']!;

  Color get accent => this['accent']!;

  Color get error => this['error']!;

  Color get success => this['success']!;

  ThemeColor toThemeColor() => this;
}

/// Then, create theme switching logic file:
/// Make lib/config/theme/theme_provider.dart file for this
/// (you can use any other state management technique i.e, theme_bloc.dart)
class ThemeProvider with ChangeNotifier {
  ThemeProvider();

  bool get darkTheme => _darkTheme;
  bool _darkTheme = false;

  AppThemeMode get theme => _darkTheme ? AppThemeMode.dark : AppThemeMode.light;

  void toggleTheme({bool? isDark}) async {
    _darkTheme = isDark ?? !_darkTheme;
    // Shared Pref for store theme
    final sp = await SharedPreferences.getInstance();
    sp.setBool("isDarkTheme", _darkTheme);
    notifyListeners();
  }

  void loadCurrentTheme(BuildContext context,
      {ThemeMode themeMode = ThemeMode.system}) async {
    final sp = await SharedPreferences.getInstance();
    final isDarkMode = sp.getBool("isDarkTheme");
    if (isDarkMode == null) {
      final useDarkTheme = switch (themeMode) {
        ThemeMode.system =>
          AppResponsiveTheme.colorModeOf(context) == AppThemeMode.dark,
        ThemeMode.light => false,
        ThemeMode.dark => true,
      };
      _darkTheme = useDarkTheme;
    } else {
      _darkTheme = isDarkMode;
    }
    notifyListeners();
  }
}

/// My App - Responsive Theme Configuration
///
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    /// TODO : must implement '[ThemeConfig.init]' to make responsive design
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ThemeConfig.init(context);
      context.read<ThemeProvider>().loadCurrentTheme(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// see Theme Switching section
    return Consumer<ThemeProvider>(
      builder: (context, state, _) {
        return AppResponsiveTheme(
          themeMode: state.theme,
          config: ColorConfig(
            lightColors: AppColors.light().toThemeColor(),
            darkColors: AppColors.dark().toThemeColor(),
          ),
          child: MaterialApp(
            title: 'Responsive Theme App',
            theme: state.darkTheme ? ThemeData.dark() : ThemeData.light(),
            // themeMode: state.darkTheme ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: MyHomePage(),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = "Responsive Theme Demo";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Txt.title18(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: Icon(Icons.brightness_4_outlined),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: Insets.medium16.paddingAll,
          children: <Widget>[
            VGap.large24(),
            Txt.title24('Welcome to Responsive Theme',
                color: context.colors.primary),
            VGap.medium16(),
            Txt.regular16(
              'Build beautiful responsive apps with ease',
              color: context.colors.success,
            ),
            VGap.large24(),
            const Txt.regular16('You have pushed the button this many times:'),
            Txt('$_counter', style: context.textTheme?.title18),
            VGap.large24(),

            // Different text styles
            Txt.titleX('Extra Large Title'),
            Txt.title32('Large Title'),
            Txt.title24('Medium Title'),
            Txt.title18('Small Title'),
            Txt.regular16('Regular text'),
            Txt.regular14('Regular smaller text'),
            Txt.small13('Small text'),
            Txt.tiny12('Tiny text'),

            // Specialized styles
            Txt.appbar('App Bar Title'),
            Txt.button('Button Text'),

            // With additional styling
            Txt.title24(
              'Styled Title',
              color: context.colors.primary,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),

            VGap.large24(), // vertical gap

            Row(
              children: [
                Icon(Icons.star),
                HGap.xsmall8(), // horizontal gap
                Txt.small13('Rating'),
              ],
            ),

            VGap.large24(), // vertical gap

            Padding(
              padding: (Insets.medium16 + 4.0).paddingAll,
              child: InkWell(
                borderRadius: RadiusSize.medium16.borderRadiusCircular,
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(4),
                  padding:
                      Insets.medium16.paddingAll, // responsive padding/margin
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    // responsive radius size with extension
                    borderRadius: RadiusSize.medium16.borderRadiusCircular,
                  ),
                  child: Txt.button('Rounded Container Button'),
                ),
              ),
            ),
            VGap.large24(), // vertical gap
            // Width-based scaling (scales with screen width)
            Container(
              width: 20.w,
              height: 30.h,
              color: context.colors.error,
              child: Center(child: Txt.title18("Error color container")),
            ),

            VGap.large24(), // vertical gap
            // Relative scaling (considers both dimensions)
            Container(
              width: 15.r,
              height: 15.r,
              color: context.colors.secondary,
              child: Center(child: Txt.title18("Secondary color container")),
            ),

            // Text scaling (adjusts for different screen sizes)
            Text('Responsive Text', style: TextStyle(fontSize: 2.t)),

            VGap.large24(), // vertical gap
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
