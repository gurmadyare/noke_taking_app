import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_provider.dart';
import 'add_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //Random Colors
  Color _getRandomColor() {
    Random random = Random();
    int red = random.nextInt(256);
    int blue = random.nextInt(256);
    int green = random.nextInt(256);

    return Color.fromARGB(220, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getRandomColor(),
      body: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Column(
          children: [
            //header

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "    Notes",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),

                //filter icon
                IconButton(
                  padding: const EdgeInsets.only(right: 30),
                  iconSize: 35,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_list,
                    color: Color.fromARGB(255, 232, 1, 244),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            //Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsetsDirectional.symmetric(vertical: 12),
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, size: 30),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            //ToDo's
            Consumer<NoteProvider>(builder: (context, todos, child) {
              return Expanded(
                child: ListView.builder(
                    itemCount: todos.todos.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          //Iscompleted
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              height: 120,
                              width: 50,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.only(left: 7),
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    Provider.of<NoteProvider>(context,
                                            listen: false)
                                        .isCompleted(index);
                                  },
                                  label: const Text(""),
                                  icon: const Center(
                                    child: Center(
                                      child: Icon(
                                        Icons.check_box,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                          ),

                          //

                          //card
                          SizedBox(
                            width: 340,
                            child: Card(
                              color: _getRandomColor(),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                title: RichText(
                                  text: TextSpan(
                                    text: "${todos.todos[index].title} \n",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 18,
                                        decoration:
                                            todos.todos[index].isCompleted!
                                                ? TextDecoration.lineThrough
                                                : null),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${todos.todos[index].subtitle} \n",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                220, 255, 255, 255),
                                            fontSize: 14,
                                            height: 1.8,
                                            decoration:
                                                todos.todos[index].isCompleted!
                                                    ? TextDecoration.lineThrough
                                                    : null),
                                      ),
                                      TextSpan(
                                        text:
                                            "Edited: ${todos.todos[index].editedDate}",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                220, 255, 255, 255),
                                            fontSize: 12,
                                            height: 1.8,
                                            fontStyle: FontStyle.italic,
                                            decoration:
                                                todos.todos[index].isCompleted!
                                                    ? TextDecoration.lineThrough
                                                    : null),
                                      ),
                                    ],
                                  ),
                                ),

                                //delete
                                trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.deepPurple,
                                            title: const Text(
                                              "Are you sure to delete?",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            icon: const Icon(Icons.info,
                                                color: Colors.white),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    //First remove
                                                    Provider.of<NoteProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeToDo(index);

                                                    //After that close
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                  child: const Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red, size: 32),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddToDo();
          }));
        },
        elevation: 10,
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
