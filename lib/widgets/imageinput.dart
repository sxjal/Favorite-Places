import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "dart:io";

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onimageadd});

  final void Function(File image) onimageadd;
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedimage;
  final imagepicker = ImagePicker();
  var pickedimage;
  void _pickgallery() async {
    pickedimage = await imagepicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    Navigator.pop(context);
    _onpickimage(pickedimage);
  }

  void _pickcamera() async {
    pickedimage = await imagepicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    Navigator.pop(context);
    _onpickimage(pickedimage);
  }

  void _onpickimage(var pickedimage) {
    if (pickedimage == null) {
      return;
    } else {
      setState(() {
        _selectedimage = File(pickedimage.path);
      });
    }
    widget.onimageadd(_selectedimage!);
  }

  void _takepicture() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Upload Image'),
        content: const Text('Select one!'),
        actions: [
          TextButton(
            onPressed: _pickgallery,
            child: const Text('Pick Image'),
          ),
          TextButton(
            onPressed: _pickcamera,
            child: const Text('Click Image'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget contentcontainer = TextButton.icon(
      onPressed: _takepicture,
      icon: const Icon(
        Icons.image,
      ),
      label: const Text(
        "Add Image",
      ),
    );

    if (_selectedimage != null) {
      contentcontainer = GestureDetector(
        onTap: _takepicture,
        child: Image.file(
          _selectedimage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
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
      child: contentcontainer,
    );
  }
}
