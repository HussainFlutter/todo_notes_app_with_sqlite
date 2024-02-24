

import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Details",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration:  const InputDecoration(
                hintText: "Title",
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration:  const InputDecoration(
              hintText: "Descripotion",
            ),
            ),
            const SizedBox(height: 50,),
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.purple,
                      child: const Center(child: Text("Edit",style: TextStyle(color: Colors.white),)),
                    ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 40,
                    color: Colors.purple,
                    child: const Center(child: Text("Delete",style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
