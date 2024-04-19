import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme/theme.dart';

final appThemeProvider = StateProvider<bool>((ref) => false);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDarkMode = ref.watch(appThemeProvider);

    return MaterialApp(
      title: 'Flutter Light/Dark Theme',
      themeMode: isDarkMode
          ? ThemeMode.dark
          : !isDarkMode
              ? ThemeMode.light
              : ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // darkTheme: getAppTheme(context, isDarkMode),
      theme: getAppTheme(context, isDarkMode),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDarkMode = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_sharp),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(Icons.add_circle_outline),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 60),
              alignment: Alignment.center,
              child: Text(
                "Testing User",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return OutlinedButton(
                    onPressed: () {
                      ref.watch(appThemeProvider.notifier).update((state) => !isDarkMode);
                      print(isDarkMode);
                      // ref.read(appThemeProvider.notifier).state = !isDarkMode;
                    },
                    child: Text("Change Theme"));
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                    onPressed: () {
                      ref.read(appThemeProvider.notifier).state = !isDarkMode;
                    },
                    child: Text("Change Theme"));
              },
            ),
            // ListTile(
            //   leading: Icon(isDarkMode ? Icons.brightness_3 : Icons.sunny),
            //   title: Text(
            //     isDarkMode ? "Dark mode" : "Light mode",
            //     style: Theme.of(context).textTheme.titleSmall,
            //   ),
            //   trailing: Consumer(builder: (context, ref, child) {
            //     return Transform.scale(
            //       scale: 1,
            //       child: Switch(
            //         activeColor: Colors.orange,
            //         onChanged: (value) {
            //           ref.read(appThemeProvider.notifier).state = value;
            //         },
            //         value: isDarkMode,
            //       ),
            //     );
            //   }),
            // ),
            ListTile(
              leading: Icon(
                Icons.grid_on_sharp,
              ),
              title: Text(
                "Story",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings and Privacy", style: Theme.of(context).textTheme.titleSmall),
            ),
            ListTile(
              leading: Icon(Icons.chat_outlined),
              title: Text(
                "Help Center",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(
                "Notification",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
