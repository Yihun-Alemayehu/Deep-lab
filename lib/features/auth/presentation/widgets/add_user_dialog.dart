import 'package:deep_lab/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;
  const AddUserDialog({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    const avatar =
                        'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/961.jpg';
                    context.read<AuthCubit>().createUser(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar: avatar);
                    Navigator.pop(context);
                  },
                  child: const Text('Create User'))
            ],
          ),
        ),
      ),
    );
  }
}
