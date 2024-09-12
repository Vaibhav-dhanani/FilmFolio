import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class VideoInput extends StatefulWidget {
  // final Function(File) onVideoSelected;

  const VideoInput({Key? key}) : super(key: key);

  @override
  _VideoInputState createState() => _VideoInputState();
}

class _VideoInputState extends State<VideoInput> {
  File? _video;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
      // widget.onVideoSelected(_video!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: _pickVideo,
          icon: const Icon(Icons.video_library),
          label: const Text('Select Trailer Video'),
        ),
        if (_video != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Selected video: ${path.basename(_video!.path)}'),
          ),
      ],
    );
  }
}