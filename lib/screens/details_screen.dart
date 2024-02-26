

import 'package:flutter/material.dart';
import 'package:todo_notes_with_sqlite/data_base_helper.dart';
import 'package:todo_notes_with_sqlite/models/note_model.dart';

import '../utils/custom_button.dart';

class DetailsScreen extends StatefulWidget {
  final String appBarTitle;
  final int? id;
  final String? title;
  final String? description;
  final Priority? priority;
  final String? createAt;
  const DetailsScreen({super.key,this.priority,this.createAt,required this.appBarTitle, this.id,  this.title,  this.description});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> priorities = ["low", "med", "high"];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedPriority = "low";
  Priority priority = Priority.low;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if(widget.title != null)
      {
        titleController.text = widget.title!;
      }
    if(widget.description != null)
    {
      descriptionController.text = widget.description!;
    }
    if(widget.priority != null)
      {
        if(widget.priority == Priority.low)
          {
            selectedPriority = "low";
            priority = Priority.low;
          }
        else if (widget.priority == Priority.med){
          selectedPriority = "med";
          priority = Priority.med;
        }
        else if (widget.priority == Priority.high){
          selectedPriority = "high";
          priority = Priority.high;
        }

      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
        title:  Text(widget.appBarTitle,style: const TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButton(
                value: selectedPriority,
                items: priorities.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (changedValue) {
                  _setPriority(changedValue);
                },
              ),
              TextFormField(
                controller: titleController,
                validator: (value){
                  if(value == null || value.isEmpty) {
                    return "Title required";
                  }
                  if (value.length <= 3)
                    {
                      return "Title must be at least 4 letters long";
                    }
                  return null;
                },
                decoration:  const InputDecoration(
                  hintText: "Title",
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration:  const InputDecoration(
                hintText: "Description",
              ),
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  widget.id == null
                  ?
                  CustomButton(
                      onTap: (){
                        if(key.currentState!.validate())
                        {
                          DataBaseHelper
                              .addNote(
                              NoteModel(
                                createAt: DateTime.now().toString(),
                                title: titleController.text,
                                description: descriptionController.text,
                                priority: priority,
                              )).then((value) {
                            ScaffoldMessenger
                                .of(context)
                                .showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Note Added"))
                            );
                            Navigator.pop(context);
                          });
                        }
                  }, title: "Save")
                  : CustomButton(
                    onTap: ()async{
                      if(key.currentState!.validate())
                      {
                        await DataBaseHelper.updateNote(NoteModel(
                          id: widget.id,
                          title: widget.title,
                          description: widget.description,
                          priority: priority,
                          createAt: widget.createAt,
                        )).then((value) => Navigator.pop(context));
                      }
                    },
                    title: "Update",
                  ),
                  const SizedBox(width: 10,),
                  widget.id != null
                      ?  CustomButton(
                    onTap: ()async{
                      await DataBaseHelper.deleteNote(NoteModel(id: widget.id))
                          .then((value) => Navigator.pop(context));
                    },
                    title: "Delete",
                  )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _setPriority (String? changedValue) {
    setState(() {
      if(changedValue! == "low")
      {
        selectedPriority = "low";
        priority = Priority.low;
      }
      else if(changedValue == "med")
      {
        selectedPriority = "med";
        priority = Priority.med;
      }
      else if(changedValue == "high")
      {
        selectedPriority = "high";
        priority = Priority.high;
      }
    });
  }
}
