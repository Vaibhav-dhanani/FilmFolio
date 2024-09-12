import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class PhotoSection extends StatefulWidget {
  final List<String> photos;
  final String moviename;
  final Function(List<String>) onPhotosChanged;

  const PhotoSection({
    Key? key,
    required this.photos,
    required this.moviename,
    required this.onPhotosChanged,
  }) : super(key: key);

  @override
  State<PhotoSection> createState() => _PhotoSectionState();
}

class _PhotoSectionState extends State<PhotoSection> {
  List<String> _photoUrls = [];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _photoUrls = widget.photos;
  }

  Future<void> _pickAndUploadImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _isUploading = true;
      });

      try {
        for (var image in selectedImages) {
          String? downloadUrl = await _uploadImage(File(image.path));
          if (downloadUrl != null) {
            setState(() {
              _photoUrls.add(downloadUrl);
            });
          }
        }
        _updateParentPhotos();
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = FirebaseStorage.instance.ref().child('filmfolio/$widget.moviename/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _removeImage(int index) {
    setState(() {
      _photoUrls.removeAt(index);
    });
    _updateParentPhotos();
  }

  void _updateParentPhotos() {
    widget.onPhotosChanged(_photoUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: _isUploading ? null : _pickAndUploadImages,
          child: _isUploading
              ? const CircularProgressIndicator()
              : const Text('Add Photos'),
        ),
        const SizedBox(height: 8),
        if (_photoUrls.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _photoUrls.asMap().entries.map((entry) {
              int index = entry.key;
              String imageUrl = entry.value;
              return Stack(
                children: [
                  Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}