import 'package:flutter/material.dart';
import 'package:todo_notes_with_sqlite/data_base_helper.dart';
import 'package:todo_notes_with_sqlite/screens/details_screen.dart';
import 'package:todo_notes_with_sqlite/models/note_model.dart'as model;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> priorities = ["low", "med", "high"];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Notes",style: TextStyle(color: Colors.white),),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)
              => const DetailsScreen(appBarTitle: "Add Note"))
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
  Widget _body() {
    return FutureBuilder(
      future: DataBaseHelper().getNotes(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done)
          {
            print("snapshot Data  ${snapshot.data}");
            if(snapshot.data == null)
            {
              return const Center(child: Text("Add some Notes"));
            }
            else
            {
              final data = snapshot.data;
              return RefreshIndicator(
                onRefresh: ()async{
                  setState(() {

                  });
                },
                child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context,index){
                    return Card(
                      elevation: 2,
                      child:  ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)
                              => DetailsScreen(title: data[index].title,
                                  description:data[index].description ,
                                  id: data[index].id,
                                  appBarTitle: "Edit Note",
                                  createAt: data[index].createAt,
                                  priority: data[index].priority,
                              ))
                          );
                        },
                        leading:  CircleAvatar(
                          backgroundColor: getPriorityColor(data[index].priority!),
                          child: getPriorityIcon(data[index].priority!),
                        ),
                        title:  Text(data[index].title!),
                        subtitle:  Text(data[index].description ?? ""),
                        trailing: IconButton(onPressed: (){
                          DataBaseHelper.deleteNote(model.NoteModel(id:data[index].id ));
                          setState(() {

                          });
                          //DataBaseHelper().getNotes();
                        }, icon: const Icon(Icons.delete)),
                      ),
                    );
                  },
                ),
              );
            }
          }
        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const CircularProgressIndicator();
          }
        return const Text("empty");
      },
    );
  }
  Color getPriorityColor (model.Priority priority) {
    switch(priority)
    {
      case model.Priority.low:
        return Colors.grey;
      case model.Priority.med:
        return Colors.yellow;
      case model.Priority.high:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  Icon getPriorityIcon (model.Priority priority) {
    switch(priority)
    {
      case model.Priority.low:
        return const Icon(Icons.low_priority);
      case model.Priority.med:
        return const Icon(Icons.arrow_back);
      case model.Priority.high:
        return const Icon(Icons.arrow_back_outlined);
      default:
        return const Icon(Icons.low_priority);
    }
  }
}