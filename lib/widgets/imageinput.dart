import "package:flutter/material.dart";

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  void _takepicture() {}

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
        onPressed: () {},
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
