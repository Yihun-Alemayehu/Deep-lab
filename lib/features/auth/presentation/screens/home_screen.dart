import 'package:deep_lab/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:deep_lab/features/auth/presentation/widgets/add_user_dialog.dart';
import 'package:deep_lab/features/auth/presentation/widgets/loading_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthCubit>().getAllUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthErrorState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage)));
      } else if (state is UserCreatedState) {
        getUsers();
      }
    }, builder: (context, state) {
      return Scaffold(
        body: state is GettingAllUsersState
            ? const Center(
                child: LoadingColumn(message: 'fetching all users'),
              )
            : state is CreatingUserState
                ? const Center(
                    child: LoadingColumn(message: 'creating new user'),
                  )
                : state is UsersLoadedState
                    ? Center(
                        child: ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              leading: Image.network(user.avatar),
                              title: Text(user.name),
                              subtitle: Text(user.createdAt),
                            ); 
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddUserDialog(nameController: nameController,),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add User')),
      );
    });
  }
}
