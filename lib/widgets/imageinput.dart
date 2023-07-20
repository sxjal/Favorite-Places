import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "dart:io";

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedimage;
  void _takepicture() async {
    final imagepicker = ImagePicker();
    final pickedimage = await imagepicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedimage == null) {
      return;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: TextButton.icon(
        onPressed: _takepicture,
        icon: const Icon(
          Icons.image,
        ),
        label: const Text(
          "Add Image",
        ),
      ),
    );
  }
}
