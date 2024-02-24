import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Notes",style: TextStyle(color: Colors.white),),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
  Widget _body() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context,index){
        return Card(
          elevation: 2,
          child:  ListTile(
            leading: const CircleAvatar(),
            title: const Text("Title"),
            subtitle: const Text("description"),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
          ),
        );
      },
    );
  }
}