# Responsive Theme

A Flutter package designed to simplify responsive theming in your applications, allowing you to create beautiful, consistent UIs that adapt to different screen sizes and device themes.

[![pub package](https://img.shields.io/badge/pub-v1.0.0-blue)](https://pub.dev/packages/responsive_theme)
[![license](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/licenses/MIT)

## Features

- 🎨 **Theming System**: Easy light/dark mode implementation
- 📱 **Responsiveness**: Adaptive UI components based on screen size
- 🔤 **Typography**: Predefined text styles for consistent typography
- 🔲 **Spacing Utilities**: Standardized spacing components
- 📐 **Border Radius Helpers**: Consistent rounded corners
- 🧩 **Padding Utilities**: Simplified padding implementation
- 🎯 **Precise Scaling**: Screen-aware size calculations

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  responsive_theme:
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Setup

1. First, create your color configurations:

```dart
import 'package:responsive_theme/responsive_theme.dart';
import 'package:flutter/material.dart';

// Define you colors
class AppColors {
  final Color background;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color error;
  final Color success;

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

```

2. Wrap your app with `AppResponsiveTheme`:

```dart
import 'package:responsive_theme/responsive_theme.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    /// TODO : must implement '[ThemeConfig.init]' to make responsive design
    ThemeConfig.init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.themeProvider.loadCurrentTheme(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// show Theme Switching section
    return Consumer<ThemeProvider>(builder: (context, state, _) {
      return AppResponsiveTheme(
        themeMode: state.theme,
        config: ColorConfig(
          lightColors: AppColors.light().toThemeColor(),
          darkColors: AppColors.dark().toThemeColor(),
        ),
        child: MaterialApp(
          title: 'Responsive Theme App',
          home: MyHomePage(),
        ),
      );
    }
    );
  }
}

```

3. Access theme data in your widgets:

```dart
import 'package:responsive_theme/responsive_theme.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors['background'],
      appBar: AppBar(
        title: Txt.title18('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Txt.title24(
              'Welcome to Responsive Theme',
              color: context.colors.primary,
            ),
            VGap.medium16(),
            Txt.regular16(
              'Build beautiful responsive apps with ease',
              color: context.colors.black80,
            ),
          ],
        ),
      ),
    );
  }
}
```

### Theme Switching

You can implement theme switching using a `ChangeNotifier` (or use any other state management technique):
(You can copy and paste in your project and customize as per your need.)

```dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:responsive_theme/responsive_theme.dart";

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

  void loadCurrentTheme(BuildContext context, {ThemeMode themeMode = ThemeMode.system}) async {
    final sp = await SharedPreferences.getInstance();
    final isDarkMode = sp.getBool("isDarkTheme");
    if (isDarkMode == null) {
      final useDarkTheme = switch(themeMode){
        ThemeMode.system => AppResponsiveTheme.colorModeOf(context) == AppThemeMode.dark,
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
```

Load current theme : 

```dart
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ThemeProvide>().loadCurrentTheme(context);
    });
  }
  /// .... other codes ...
  /// ...
```

Toggle theme : 

```dart
onPressed: () {
  context.read<ThemeProvider>().toggleTheme();
}

// set to specific dark
onPressed: () {
  context.read<ThemeProvider>().toggleTheme(isDark: true);
}
```


Then use it with `AppResponsiveTheme`:

```dart
AppResponsiveTheme(
  themeMode: themeProvider.theme,
  config: ColorConfig(
    lightColors: AppColors.light().toThemeColor(),
    darkColors: AppColors.dark().toThemeColor(),
  ),
  child: MaterialApp(
    // ...
  ),
)
```

## Key Components

### Text Components

Use the `Txt` widget for consistent typography:

```dart
// Different text styles
Txt.titleX('Extra Large Title')
Txt.title32('Large Title')
Txt.title24('Medium Title')
Txt.title18('Small Title')
Txt.regular16('Regular text')
Txt.regular14('Regular smaller text')
Txt.small13('Small text')
Txt.tiny12('Tiny text')

// Specialized styles
Txt.appbar('App Bar Title')
Txt.button('Button Text')

// With additional styling
Txt.title24(
  'Styled Title',
  color: context.colors.primary,
  maxLines: 2,
  textAlign: TextAlign.center,
)
```

### Spacing Components

Use `VGap` and `HGap` for consistent vertical and horizontal spacing:

```dart
Column(
  children: [
    Txt.title24('Title'),
    VGap.medium16(), // 16px vertical gap
    Txt.regular16('Description'),
    VGap.large24(), // 24px vertical gap
    Row(
      children: [
        Icon(Icons.star),
        HGap.xsmall8(), // 8px horizontal gap
        Txt.small13('Rating'),
      ],
    ),
  ],
)
```

### Border Radius Extensions

Use border radius extensions for consistent rounded corners:

```dart
Container(
  decoration: BoxDecoration(
    color: context.colors.primary,
    borderRadius: RadiusSize.medium16.borderRadiusCircular,
  ),
  child: Text('Rounded Container'),
)

// Available radius sizes
RadiusSize.zero
RadiusSize.xsmall4
RadiusSize.small8
RadiusSize.medium16
RadiusSize.medium20
RadiusSize.medium24
RadiusSize.medium28
RadiusSize.big44
RadiusSize.custom(value)
```

### Padding Extensions

Use padding extensions for consistent spacing:

```dart
Container(
  padding: Insets.medium16.paddingAll,
  child: Text('Padded text'),
)

Container(
  padding: Insets.medium16.paddingHorizontal,
  child: Text('Horizontally padded text'),
)

// Available padding sizes
Insets.zero
Insets.xxsmall4
Insets.xsmall8
Insets.small10
Insets.small12
Insets.medium16
Insets.medium18
Insets.medium20
Insets.large24
Insets.xlarge32
Insets.xxlarge40
Insets.xxxlarge66
Insets.xxxxlarge80
Insets.custom(value)
```

### Responsive Scaling

Use the extension methods to scale dimensions based on screen size:

```dart
// Width-based scaling (scales with screen width)
Container(width: 20.w, height: 30.h)

// Relative scaling (considers both dimensions)
Container(width: 15.r, height: 15.r)

// Text scaling (adjusts for different screen sizes)
Text('Responsive Text', style: TextStyle(fontSize: 18.t))
```

### Context Extensions

Access theme data from any widget with context extensions:

```dart
// Access colors
final primaryColor = context.colors.primary;
final backgroundColor = context.colors['background']; //or use with extension : context.colors.background

// Access typography theme
final titleStyle = context.textTheme?.title24;

// Check device theme
final isDarkMode = context.isDeviceThemeDark;
```

## Advanced Configuration

### Theme Config for Responsive Design

Use `ThemeConfig` to handle different screen sizes:

```dart
// Initialize in your app's root
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize ThemeConfig
    ThemeConfig.init(context);
    
    return AppResponsiveTheme(
      // ...
    );
  }
}

// Use responsive values
Container(
  padding: EdgeInsets.all(
    ThemeConfig().value(16, tablet: 24, desktop: 32)
  ),
  // ...
)
```

## Tips for Effective Use

1. **Be Consistent**: Use the predefined text styles, spacing, and radius values for a consistent look.

2. **Responsive Design**: Use the `.w`, `.h`, `.r`, and `.t` extensions to create layouts that adapt to different screen sizes.

3. **Theme Toggling**: Implement a theme provider that allows users to toggle between light and dark modes.

4. **Organization**: Create a dedicated theme configuration file where you define all your colors and theme settings.

5. **Reusable Components**: Build reusable UI components that leverage the theme system for consistent styling.

## Example Project

Check out the [example project](https://github.com/Parmar24c/responsive_theme/tree/main/example) for a complete implementation of responsive_theme.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Created by Nayan Parmar © 2025.