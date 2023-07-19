import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:favorite_places/providers/additemProvider.dart";

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  var text = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
