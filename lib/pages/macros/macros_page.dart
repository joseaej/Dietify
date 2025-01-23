import 'package:flutter/material.dart';

class MacrosPage extends StatefulWidget {
  const MacrosPage({super.key});

  @override
  State<MacrosPage> createState() => _MacrosPageState();
}

class _MacrosPageState extends State<MacrosPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double _macroSliderValue = 84;
  double _sleepSliderValue = 85;
  double _waterSliderValue = 65;

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
                  _buildMacroNutrientsCard(),
                  const SizedBox(height: 16),
                  _buildSleepTrackingCard(context),
                  const SizedBox(height: 16),
                  _buildWaterIntakeCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMacroNutrientsCard() {
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
                  Text('${(_macroSliderValue / 100 * 2200).toInt()}',
                      style: const TextStyle(fontSize: 16)),
                  const Text('of 2,200 calories'),
                ],
              ),
              CircleAvatar(
                radius: 30,
                child: Text('${_macroSliderValue.toInt()}%'),
              ),
            ],
          ),
          Slider(
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
              _buildMacroInfo('65g', 'Fats', '75%'),
              _buildMacroInfo('180g', 'Protein', '90%'),
              _buildMacroInfo('220g', 'Carbs', '82%'),
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
                  if (_sleepSliderValue>=0 && _sleepSliderValue<=30) {
                    return const Text('You need to start tracking!');
                  }else if(_sleepSliderValue>30 && _sleepSliderValue<=60){
                    return const Text('You can do better!');
                  }else{
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

  Widget _buildWaterIntakeCard() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Water Intake',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              CircleAvatar(
                radius: 30,
                child: Text('${_waterSliderValue.toInt()}%'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: _waterSliderValue,
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                _waterSliderValue = value;
              });
            },
          ),
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

  Widget _buildCard({required Widget child}) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}
