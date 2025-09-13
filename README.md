# 🪙 Flip to Save

**"Flip the coin. Save your money."**

A Flutter app designed to help users overcome impulse buying by using a simple coin flip mechanism that always results in "No" - encouraging users to save money instead of making unnecessary purchases.

## 📱 Features

### Core Functionality
- **🪙 Coin Flip Animation**: Beautiful 3D coin flip animation that always shows "NO" to prevent impulse purchases
- **💬 Motivational Messages**: Random encouraging messages after each flip to reinforce the saving habit
- **💰 Savings Tracker**: Track how much money you've saved by not making impulse purchases
- **🔥 Streak System**: Monitor daily usage streaks to build consistent saving habits
- **📊 Statistics Dashboard**: View total savings, current/best streaks, and usage analytics

### Additional Features
- **🎨 Clean UI**: Minimal, modern design with intuitive navigation
- **💾 Local Storage**: All data stored locally using Hive database - no internet required
- **⚙️ Settings**: Manage your data with reset options and view detailed statistics
- **📱 Splash Screen**: Professional branded loading screen

## 🎯 How It Works

1. **Feel an impulse to buy something?** Open the app
2. **Tap "Flip Coin"** and watch the beautiful animation
3. **See "NO" result** with a motivational message
4. **Enter the amount** you almost spent to track your savings
5. **Build streaks** by using the app daily to resist impulses

## 🏗️ Project Structure

```
lib/
├── main.dart                   # App entry point with splash screen
├── db/
│   └── database_service.dart   # Hive database operations
├── models/
│   ├── app_data.dart          # App settings & statistics model
│   ├── flip_record.dart       # Flip history model
│   └── *.g.dart              # Generated Hive adapters
├── providers/
│   └── savings_provider.dart  # State management with Provider
├── screens/
│   ├── home_screen.dart       # Main app interface
│   └── settings_screen.dart   # Settings and data management
└── widgets/
    └── coin_flip_widget.dart  # Animated coin flip component
```

## 🛠️ Tech Stack

- **Framework**: Flutter (Latest Stable)
- **State Management**: Provider Pattern
- **Local Database**: Hive + Hive Flutter
- **Animations**: Flutter's built-in AnimationController
- **Code Generation**: build_runner for Hive adapters

### Dependencies
- `provider: ^6.1.1` - State management
- `hive: ^2.2.3` - Local database
- `hive_flutter: ^1.1.0` - Flutter integration for Hive
- `flutter_spinkit: ^5.2.0` - Loading animations
- `path_provider: ^2.1.1` - File system paths

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/varunshihara/fliptosave.git
   cd fliptosave
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   dart run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📊 App Statistics

The app tracks several metrics to help users understand their saving habits:

- **Total Saved**: Lifetime amount saved from avoided purchases
- **Current Streak**: Consecutive days of using the app
- **Best Streak**: Highest streak achieved
- **Total Flips**: Number of times the coin has been flipped
- **Average Savings**: Average amount saved per flip
- **Monthly Total**: Current month's total savings

## 🎨 Screenshots

*Screenshots coming soon...*

## 🏷️ App Information

- **Package Name**: `in.codewithvarun.fliptosave`
- **App Name**: Flip to Save
- **Version**: 1.0.0
- **Platform**: Android, iOS

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💡 Inspiration

This app was created to help people build better financial habits by providing a simple, fun way to resist impulse purchases. The psychology behind the coin flip (which always shows "NO") gives users a moment to pause and reconsider their purchase decision.

## 📞 Contact

**Varun Shihara** - [@varunshihara](https://github.com/varunshihara)

Project Link: [https://github.com/varunshihara/fliptosave](https://github.com/varunshihara/fliptosave)

---

**Made with ❤️ to help you save money**
