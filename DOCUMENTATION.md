# Responsive Theme - Documentation

A comprehensive guide to the responsive_theme Flutter package.

## Table of Contents

- [Core Concepts](#core-concepts)
- [Setup & Configuration](#setup--configuration)
- [Theming System](#theming-system)
- [Responsive Sizing](#responsive-sizing)
- [Typography](#typography)
- [Spacing & Layout](#spacing--layout)
- [Border Radius](#border-radius)
- [Utilities](#utilities)
- [Best Practices](#best-practices)
- [API Reference](#api-reference)

## Core Concepts

The responsive_theme package is built around several core concepts:

1. **Responsive Design**: Automatically adjust UI elements based on screen size and device type
2. **Theme Consistency**: Maintain consistent colors, typography, and spacing across the app
3. **Convenience Utilities**: Pre-built components and extensions to speed up development
4. **Adaptive Layout**: Layout components that intelligently adapt to the current screen context

## Setup & Configuration

### Basic Setup

1. Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  responsive_theme: ^1.0.0
```

2. Create your theme color configuration:

```dart
import 'package:responsive_theme/responsive_theme.dart';
import 'package:flutter/material.dart';

// Define your light theme colors
final lightColors = <String, Color>{
  'primary': Colors.blue,
  'secondary': Colors.green,
  'background': Colors.white,
  'text': Colors.black87,
  // Add your custom color keys as needed
};

// Define your dark theme colors
final darkColors = <String, Color>{
  'primary': Colors.indigo,
  'secondary': Colors.teal,
  'background': Colors.black,
  'text': Colors.white70,
  // Add your custom color keys as needed
};

// Create the ColorConfig with both themes
final colorConfig = ColorConfig(
  lightColors: lightColors,
  darkColors: darkColors,
);
```

3. Wrap your app with AppResponsiveTheme:

```dart
void main() {
  runApp(
    MaterialApp(
      home: AppResponsiveTheme(
        config: colorConfig,
        // Optional: Override system theme preference
        // themeMode: AppThemeMode.dark,
        child: MyApp(),
      ),
    ),
  );
}
```

4. Initialize the ThemeConfig in your main widget:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Must be called to initialize responsive calculations
    ThemeConfig.init(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Txt.appbar("My App"),
      ),
      body: MyAppContent(),
    );
  }
}
```

## Theming System

### AppThemeData

The core theming class that contains colors and typography information:

```dart
final themeData = AppThemeData.regular(lightColors);

// To switch theme colors only:
final darkThemeData = themeData.withColors(darkColors);
```

### Accessing Theme Colors

Use the BuildContext extension to access colors:

```dart
Widget build(BuildContext context) {
  // Access a color from the theme
  final primaryColor = context.colors['primary'];
  
  return Container(
    color: primaryColor,
    child: Text('Themed content'),
  );
}
```

### Theme Detection

Check if the device is using dark mode:

```dart
if (context.isDeviceThemeDark) {
  // Handle dark mode specific logic
}
```

## Responsive Sizing

### Device Detection

The `ThemeConfig` class provides properties to detect the current device type:

```dart
final config = ThemeConfig();

if (config.isMobile) {
  // Mobile-specific layout
} else if (config.isTablet) {
  // Tablet-specific layout
} else if (config.isDesktop) {
  // Desktop-specific layout
}

// Check orientation
if (config.isPortrait) {
  // Portrait layout
} else if (config.isLandscape) {
  // Landscape layout
}
```

### Responsive Values

Use the `value()` method to provide different values based on screen size:

```dart
final fontSize = config.value(16, tablet: 18, desktop: 20);
final padding = config.value(
  EdgeInsets.all(8),
  tablet: EdgeInsets.all(16),
  desktop: EdgeInsets.all(24),
);
```

### Predefined Gutters

Use predefined gutter values that adapt to device size:

```dart
// Use appropriate spacing between elements
final spacing = config.gutterSmall;  // 8px on mobile, 16px on tablet, 24px on desktop
final mediumSpacing = config.gutterMedium;  // 16px on mobile, 24px on tablet, 32px on desktop
final largeSpacing = config.gutterLarge;  // 24px on mobile, 32px on tablet, 48px on desktop
```

### Responsive Extensions

Special sizing extensions for responsive measurements:

```dart
// Relative to screen width (percentage based)
final widthSize = 10.w;  // 10% of screen width

// Relative to screen height (percentage based)
final heightSize = 5.h;  // 5% of screen height

// Proportional to text size factor (for typography)
final textSize = 1.5.t;  // Scaled based on diagonal screen size

// Responsive size (average of width and height sizing)
final responsiveSize = 8.r;  // Balanced sizing for UI elements
```

## Typography

### Text Styles

The package provides a set of predefined text styles:

- `titleX64`: Large titles (64px, medium weight)
- `title32`: Main headings (32px, medium weight)
- `title24`: Section headings (24px, medium weight)
- `title18`: Subheadings (18px, medium weight)
- `regular16`: Standard body text (16px, regular weight)
- `regular14`: Default body text (14px, regular weight)
- `small13`: Small text (13px, regular weight)
- `tiny12`: Extra small text (12px, regular weight)

### Txt Widget

The `Txt` widget provides an easy way to apply consistent typography:

```dart
// Basic usage
Txt(
  "Hello world",
  level: AppTextLevel.title24,
  color: Colors.blue,
)

// Convenience constructors
Txt.title24("Section heading")
Txt.regular16("Body text")
Txt.small13("Small print")

// Special purpose constructors
Txt.appbar("App Bar Title")
Txt.button("BUTTON TEXT")
```

### Text Extensions

Apply text styles directly to Text widgets:

```dart
Text("Hello world").title24(context)
```

## Spacing & Layout

### Insets

Predefined padding values:

```dart
// Static values
Insets.xxsmall4  // 4px
Insets.xsmall8   // 8px
Insets.small12   // 12px
Insets.medium16  // 16px
Insets.large24   // 24px
Insets.xlarge32  // 32px
// etc.

// Custom value
Insets.custom(42)  // 42px with scaling applied
```

### Padding Extensions

Easy-to-use padding extensions:

```dart
// Apply padding to a container
Container(
  padding: Insets.medium16.paddingAll,
  child: Text("Padded content"),
)

// Horizontal or vertical padding
Container(
  padding: Insets.medium16.paddingHorizontal,
  child: Text("Horizontally padded content"),
)
```

### Gap Widgets

Pre-made spacing widgets for layout:

```dart
Column(
  children: [
    Text("First item"),
    VGap.medium16(),  // 16px vertical space
    Text("Second item"),
    VGap.large24(),   // 24px vertical space
    Text("Third item"),
  ],
)

Row(
  children: [
    Text("First"),
    HGap.medium16(),  // 16px horizontal space
    Text("Second"),
  ],
)
```

## Border Radius

Predefined border radius values and extensions:

```dart
// Use predefined values
RadiusSize.xsmall4   // 4px
RadiusSize.small8    // 8px
RadiusSize.medium16  // 16px
// etc.

// Custom radius
RadiusSize.custom(12)  // 12px with scaling applied

// Border radius extensions
Container(
  decoration: BoxDecoration(
    borderRadius: RadiusSize.medium16.borderRadiusCircular,
    color: Colors.blue,
  ),
)

// Special border radius types
RadiusSize.medium16.borderRadiusTop     // Rounded top corners only
RadiusSize.medium16.borderRadiusBottom  // Rounded bottom corners only
RadiusSize.medium16.borderRadiusLeft    // Rounded left corners only
RadiusSize.medium16.borderRadiusRight   // Rounded right corners only
```

## Utilities

### Color Utilities

Get predefined colors by name:

```dart
final blueColor = getStatusColorFromCode('blue');
final redColor = getStatusColorFromCode('red');
// Supported colors: grey, red, pink, purple, indigo, blue, cyan, 
// green, lime, amber, orange, brown, gray, light-grey
```

## Best Practices

1. **Initialize ThemeConfig**: Always call `ThemeConfig.init(context)` in your main app widget.

2. **Use Txt Widget**: Prefer the `Txt` widget over standard Text for consistent typography.

3. **Responsive Sizing**: Use `.w`, `.h`, `.t`, and `.r` extensions for truly responsive layouts.

4. **Theme Colors**: Access theme colors through `context.colors['keyName']` rather than hardcoding.

5. **Predefined Values**: Use predefined `Insets` and `RadiusSize` values for consistent UI.

6. **Gap Widgets**: Use `VGap` and `HGap` widgets for standardized spacing.

7. **Responsive Values**: Use `config.value()` to provide different values for different screen sizes.

## API Reference

### Core Classes

- `AppTheme`: InheritedWidget that provides theme data to descendants
- `AppThemeData`: Container for theme colors and typography styles
- `AppResponsiveTheme`: Widget that manages theme state and automatic detection
- `ThemeConfig`: Utility class for responsive calculations and device detection

### Typography

- `AppTypographyData`: Contains all text styles for the theme
- `AppTextLevel`: Enum for text hierarchy levels
- `Txt`: Widget for applying themed text styles

### Layout

- `Insets`: Predefined padding values
- `VGap`: Vertical spacing widget
- `HGap`: Horizontal spacing widget
- `RadiusSize`: Predefined border radius values

### Extensions

- `BuildContextX`: Extensions on BuildContext for theme access
- `RadiusExt`: Extensions on double for border radius creation
- `PaddingX`: Extensions on double for padding creation
- `SizeConfigExtension`: Extensions for responsive sizing
- `Styles`: Extensions on Text for applying typography styles
- `CopyWith`: Extension on Text for easy property modifications

### Utilities

- `getStatusColorFromCode`: Get color from predefined color names
- `ColorConfig`: Configuration for light and dark theme colors
- `AppThemeMode`: Enum for light/dark theme selection