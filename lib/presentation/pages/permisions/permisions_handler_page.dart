import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermisionsHandlerPage extends StatelessWidget {
  const PermisionsHandlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PermissionsGate(
      child: Scaffold(
        appBar: AppBar(title: const Text('Permisos')),
        body: Center(child: Text('Contenido de la app')),
      ),
    );
  }
}

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
    setState(() {
      _checkingPermissions = true;
    });

    final storageStatus = await Permission.storage.status;

    if (storageStatus.isGranted) {
      await Permission.notification.request();

      if (mounted) {
        setState(() {
          _permissionsGranted = true;
          _checkingPermissions = false;
        });
      }
      return;
    }

    final result = await [Permission.storage].request();

    final storageGranted = result[Permission.storage]?.isGranted ?? false;
    final storagePermanentlyDenied =
        result[Permission.storage]?.isPermanentlyDenied ?? false;

    if (mounted) {
      setState(() {
        _permissionsGranted = storageGranted;
        _permissionsPermanentlyDenied = storagePermanentlyDenied;
        _checkingPermissions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingPermissions) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_permissionsGranted) {
      return widget.child;
    }

    if (_permissionsPermanentlyDenied) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Debes conceder permiso de almacenamiento desde ajustes para continuar',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: openAppSettings,
                child: const Text('Abrir ajustes'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _checkPermissions,
          child: const Text('Conceder permisos'),
        ),
      ),
    );
  }
}
