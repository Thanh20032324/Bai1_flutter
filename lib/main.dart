import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class UserItem {
  String name;
  String age;

  UserItem({
    required this.name,
    required this.age,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bai 1',
      home: Bai1(),
    );
  }
}

class Bai1 extends StatefulWidget {
  @override
  _Bai1ListScreenState createState() => _Bai1ListScreenState();
}

class _Bai1ListScreenState extends State<Bai1> {
  List<UserItem> users = [];
  TextEditingController  _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  void _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm người mới'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Họ tên'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Tuổi'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Lưu'),
              onPressed: () {
                setState(() {
                  users.add(
                    UserItem(
                      name: _nameController.text,
                      age: _ageController.text,
                    ),
                  );
                  _nameController.clear();
                  _ageController.clear();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _editTodo(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chỉnh Sửa '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Họ tên'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Tuổi'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Lưu'),
              onPressed: () {
                setState(() {
                  users[index].name = _nameController.text;
                  users[index].age = _ageController.text;
                  _nameController.clear();
                  _ageController.clear();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTodo(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Người Dùng'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/th.jpg'),
            fit: BoxFit.cover,
          ),
        ),

      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].age),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _nameController.text = users[index].name;
                    _ageController.text = users[index].age;
                    _editTodo(index);
                  },

                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteTodo(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );

  }
}