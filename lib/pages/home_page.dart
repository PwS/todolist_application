import 'package:flutter/material.dart';
import 'package:todolist_application/models/task.dart';
import 'package:todolist_application/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _task = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _taskList(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Add Task'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) => setState(() {
                          _task = value;
                        }),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Task'),
                      ),
                      MaterialButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          if (_task == null || _task == '') return;
                          _databaseService.addTask(_task!);
                          setState(() {
                            _task = null;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _taskList() {
    return FutureBuilder(
      future: _databaseService.getTasks(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            Task task = snapshot.data![index];
            return Dismissible(
              key: ValueKey<Task>(task), // Ensure the key is unique for each item
              background: Container(
                color: Colors.green,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.undo, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Cancel', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Delete', style: TextStyle(color: Colors.white)),
                    SizedBox(width: 10),
                    Icon(Icons.delete, color: Colors.white),
                  ],
                ),
              ),
              direction: DismissDirection.horizontal,
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  // Cancel action (left-to-right)
                  // Return false to prevent dismissal
                  return false;
                } else if (direction == DismissDirection.endToStart) {
                  // Delete action (right-to-left)
                  return true; // Allow dismissal
                }
                return false;
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  // Handle delete action
                  snapshot.data!.removeAt(index);
                  _databaseService.deleteTask(task.id);
                  setState(() {});
                }
              },
              child: ListTile(
                title: Text(task.content),
                trailing: Checkbox(
                  value: task.status == 1,
                  onChanged: (value) {
                    _databaseService.updateTaskStatus(
                        task.id, value == true ? 1 : 0);
                    setState(() {});
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
