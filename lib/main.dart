import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreferences_project/user_pref.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SharedPreferences',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SharedPreferencesWidget(),
    );
  }
}

class SharedPreferencesWidget extends StatefulWidget {
  const SharedPreferencesWidget({super.key});

  @override
  State<SharedPreferencesWidget> createState() =>
      _SharedPreferencesWidgetState();
}

class _SharedPreferencesWidgetState extends State<SharedPreferencesWidget> {
  int count = 0;
  bool commute = false;

  @override
  void initState() {
    super.initState();
    getLastCommuteValue();
    getLastCountValue();
  }

// Incrementation function
  void addCount() {
    setState(() {
      count++;
    });

    UserPref.saveCountValue(count);
  }

// Decrementation function
  void removeCount() {
    setState(() {
      count--;
    });

    UserPref.saveCountValue(count);
  }

// Activate/deactivate function
  void updateCommute() {
    setState(() {
      commute = !commute;
    });

    UserPref.saveCommuteValue(commute);
  }

  void getLastCommuteValue() async {
    final prefs = await SharedPreferences.getInstance();
    //1
    if (prefs.containsKey(UserPref.kuserCommute)) {
      //2
      setState(() {
        final val = prefs.getBool(UserPref.kuserCommute); //3
        if (val != null) commute = val; //4
      });
    }
  }

  void getLastCountValue() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(UserPref.kuserCount)) {
      setState(() {
        final val = prefs.getInt(UserPref.kuserCount);
        if (val != null) count = val;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Appuyez sur: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton.filled(
                    onPressed: () => addCount(),
                    icon: const Icon(Icons.add),
                  ),
                  const Text('ou', style: TextStyle(fontSize: 20)),
                  IconButton.filled(
                    onPressed: () => removeCount(),
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
              Text(
                '$count',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Divider(
                height: 20,
                color: Colors.black,
              ),
              const Row(
                children: [
                  Text('Activez ou désactivez:',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              Switch(
                value: commute,
                onChanged: (value) => updateCommute(),
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
