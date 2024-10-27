import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Other Device Controls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ControlsScreen(),
    );
  }
}

class ControlsScreen extends StatefulWidget {
  const ControlsScreen({Key? key}) : super(key: key);

  @override
  _ControlsScreenState createState() => _ControlsScreenState();
}

class _ControlsScreenState extends State<ControlsScreen> {
  bool _isFlashOn = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _toggleFlash() async {
    try {
      if (_isFlashOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } on Exception catch (e) {
      _showErrorDialog('Could not access flash: $e');
    }
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 1000);
    } else {
      _showErrorDialog('No vibrator available');
    }
  }

  Future<void> _playAudio() async {
    try {
      // Replace with your audio file path
      await _audioPlayer.play(AssetSource('audio/sample.mp3'));
    } catch (e) {
      _showErrorDialog('Could not play audio: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Controls'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _toggleFlash,
              icon: Icon(_isFlashOn ? Icons.flash_off : Icons.flash_on),
              label: Text(_isFlashOn ? 'Turn Flash Off' : 'Turn Flash On'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _vibrate,
              icon: const Icon(Icons.vibration),
              label: const Text('Vibrate'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _playAudio,
              icon: const Icon(Icons.music_note),
              label: const Text('Play Audio'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}