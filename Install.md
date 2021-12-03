# Installation

**Prerequisites:**

 - [Android Studio](https://developer.android.com/studio) or any IDE to open Flutter project
 - JDK
 
**Installations:**

1. Install Flutter by following instructions from [flutter.dev](https://flutter.dev). To summarise:
   - Select the appropriate operating system
   - Download the flutter sdk to a preferred location on your local system.
   
2. Fork and clone the [mentorship-flutter](https://github.com/anitab-org/mentorship-flutter) repository to your local machine.
3. Make sure to install the **Flutter** and **Dart** plugins.
   - If mentorship Flutter is the first project that you will be viewing in Android Studio then:
       - Start Android Studio
       - Open Plugin Preferences
       - Browse repositories and search for flutter
       - Install and click yes to install Dart as well if prompted.
   - Flutter and dart can also be installed after opening a project.
       - Go to File menu -> Settings -> plugins
       - Search for the plugin. In this case it would be Flutter and Dart. Install them if not done yet and click Apply.

**Local Development Setup:**

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/jdave2/GroupPool.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 3:**

```
flutter run --no-sound-null-safety --release
```
