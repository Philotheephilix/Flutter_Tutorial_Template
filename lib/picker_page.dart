import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class PickerPage extends StatefulWidget {
  final String fileType;

  const PickerPage({Key? key, required this.fileType}) : super(key: key);

  @override
  _PickerPageState createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  File? _file;

  Future<void> _pickFile() async {
    if (widget.fileType == 'image') {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Updated method
      if (pickedFile != null) {
        setState(() {
          _file = File(pickedFile.path);
        });
      }
    } else if (widget.fileType == 'video') {
      final picker = ImagePicker();
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery); // Updated method
      if (pickedFile != null) {
        setState(() {
          _file = File(pickedFile.path);
        });
      }
    } else if (widget.fileType == 'document') {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _file = File(result.files.single.path!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.fileType.capitalize()} Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick a ${widget.fileType}'),
            ),
            if (_file != null) ...[
              if (widget.fileType == 'image') ...[
                Image.file(_file!),
              ] else if (widget.fileType == 'video') ...[
                Text('Video selected: ${_file!.path}'),
              ] else ...[
                Text('Document selected: ${_file!.path}'),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
