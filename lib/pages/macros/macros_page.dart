import 'package:Dietify/models/user.dart';
import 'package:Dietify/pages/macros/macros_viewmodel.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:Dietify/widgets/components/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MacrosPage extends StatefulWidget {
  UserApp? user;
  MacrosPage({super.key, required this.user});

  @override
  State<MacrosPage> createState() => _MacrosPageState();
}

class _MacrosPageState extends State<MacrosPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late UserApp? user;
  double _macroSliderValue = 84;
  double _sleepSliderValue = 85;
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Daily Tracking'),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMacroNutrientsCard(context),
                  const SizedBox(height: 16),
                  _buildSleepTrackingCard(context),
                  const SizedBox(height: 16),
                  _buildWaterIntakeCard(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMacroNutrientsCard(BuildContext context) {
    MacrosViewmodel viewmodel = Provider.of<MacrosViewmodel>(context);
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Macro Nutrients',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${(viewmodel.macros.currentCalories * 100 / user!.macros.totalCalories).toInt()}',
                      style: const TextStyle(fontSize: 16)),
                  Text("${user?.macros.totalCalories}"),
                ],
              ),
              CircleAvatar(
                backgroundColor: orange,
                radius: 30,
                child: Text(
                  '${_macroSliderValue.toInt()}%',
                  style: TextStyle(color: font, fontSize: 16),
                ),
              ),
            ],
          ),
          Slider(
            inactiveColor: sliderOut,
            activeColor: orange,
            thumbColor: orange,
            value: _macroSliderValue,
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                _macroSliderValue = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMacroInfo(user!.macros.fats.amount, 'Fats', '75%'),
              _buildMacroInfo(user!.macros.protein.amount, 'Protein', '90%'),
              _buildMacroInfo(user!.macros.carbs.amount, 'Carbs', '82%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroInfo(String amount, String label, String percentage) {
    return Expanded(
      child: Column(
        children: [
          Text(amount,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(label),
          Text(percentage, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSleepTrackingCard(BuildContext context) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Sleep Tracking',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('7h 30m'),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            inactiveColor: orange,
            activeColor: orange,
            thumbColor: orange,
            value: _sleepSliderValue,
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                _sleepSliderValue = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sleep Quality'),
              Builder(
                builder: (context) {
                  if (_sleepSliderValue >= 0 && _sleepSliderValue <= 30) {
                    return const Text('You need to start tracking!');
                  } else if (_sleepSliderValue > 30 &&
                      _sleepSliderValue <= 60) {
                    return const Text('You can do better!');
                  } else {
                    return Text('Congratulations, goal reached!');
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Bedtime'),
              Text('11:30 PM - 7:00 AM'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaterIntakeCard(BuildContext context) {
    MacrosViewmodel viewmodel = Provider.of<MacrosViewmodel>(context);
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Water Intake',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: orange,
                ),
                child: Center(
                  child: Text(
                    '${viewmodel.weather_radius}%',
                    style: TextStyle(color: font, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          floatingButton(
              Icon(
                Icons.water_drop_outlined,
                color: font,
              ), () {
            viewmodel.addWaterIntake();
          }),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('1.6L'),
              Text('of 2.5L'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Next Reminder'),
              Text('In 30 minutes'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required Widget child,
  }) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          side: WidgetStateProperty.all<BorderSide>(
            const BorderSide(color: Colors.transparent),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: () {},
        child: Material(
          color: Colors.transparent,
          elevation: 6,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(30),
            child: child,
          ),
        ));
  }
}
