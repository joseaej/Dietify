import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsGate extends StatefulWidget {
  final Widget child;

  const PermissionsGate({super.key, required this.child});

  @override
  State<PermissionsGate> createState() => _PermissionsGateState();
}

class _PermissionsGateState extends State<PermissionsGate> {
  bool _checkingPermissions = true;
  bool _permissionsGranted = false;
  bool _permissionsPermanentlyDenied = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final storageStatus = await Permission.storage.status;

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      setState(() {
        _permissionsGranted = true;
        _checkingPermissions = false;
      });
    } else {
      final result = await [
        Permission.camera,
        Permission.storage,
      ].request();

      final allGranted = result.values.every((status) => status.isGranted);
      final anyPermanentlyDenied = result.values.any((status) => status.isPermanentlyDenied);

      setState(() {
        _permissionsGranted = allGranted;
        _permissionsPermanentlyDenied = anyPermanentlyDenied;
        _checkingPermissions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingPermissions) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_permissionsGranted) {
      return widget.child;
    }

    if (_permissionsPermanentlyDenied) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Debes conceder permisos desde ajustes para continuar'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text('Abrir ajustes'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _checkPermissions,
            child: const Text('Conceder permisos'),
          ),
        ),
      ),
    );
  }
}
