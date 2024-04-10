import 'package:crude_bloc/logic/get_cubit/get_cubit.dart';
import 'package:crude_bloc/logic/update_cubit/update_cubit.dart';
import 'package:crude_bloc/screens/delete_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PutScreen extends StatefulWidget {
  const PutScreen({super.key});

  @override
  State<PutScreen> createState() => _PutScreenState();
}

class _PutScreenState extends State<PutScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();
  final TextEditingController createAtController = TextEditingController();
  final TextEditingController createdAtController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<GetCubit>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Update Data"),
          ),
          body: Column(
            children: [
              const Text(
                "Id For Update",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              BlocBuilder<GetCubit, GetState>(
                builder: (context, state) {
                  if (state is GetLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetLoaded) {
                    return SizedBox(
                      height: 50,
                      child: Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.getModel?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    state.getModel?[index].id ?? '1',
                                    style: const TextStyle(
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is GetError) {
                    return Center(
                      child: Text(state.errorMessage.toString()),
                    );
                  }
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
              BlocBuilder<PutCubit, PutState>(
                builder: (context, state) {
                  if (state is PutLoading) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  } else if (state is PutLoadded) {
                    return Column(
                      children: [
                        const Text(
                          "Data Update SuccessFully",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DeleteScreen(),
                                  ));
                            },
                            child: const Text("NEXT"))
                      ],
                    );
                  } else if (state is PutError) {
                    return Center(
                      child: Text(state.errorMessage.toString()),
                    );
                  } else {
                    return _putDataWidget();
                  }
                },
              ),
            ],
          )),
    );
  }

  _putDataWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Id';
                }
                return null;
              },
              controller: idController,
              decoration: const InputDecoration(
                  hintText: 'Enter Id',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Name';
                }
                return null;
              },
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                  final String id = idController.text;
                  final String name = nameController.text;
                  final String avatar = avatarController.text;
                  context.read<PutCubit>().putData(
                        id: id.toString(),
                        avatar: avatar,
                        name: name,
                      );
                },
                child: const Text("Put Data")),
          ],
        ),
      ),
    );
  }

// _successWidget(){
//   return
// }
}
