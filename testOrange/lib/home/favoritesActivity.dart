import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testorange/Get/Text.dart';
import 'package:testorange/home/ActivityModel.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _favoriteState();
}

class _favoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Activity>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: TextA(text: 'Favorites', titre: true),
        ),
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Color(0x66D6D6D6),
          ),
          child: ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) => model.update(oldIndex, newIndex),
            itemCount: model.activitys.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                hoverColor: Colors.grey,
                key: ValueKey(index.toString()),
                title: Dismissible(
                  background: Container(margin:  const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red),
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(
                          Icons.delete_forever,
                          color: Color(0xFFFFFFFF),
                        ),SizedBox(width: 10,)
                      ],
                    ),
                  ),
                  key: Key(index.toString()),
                  onDismissed: (direction) {
                    model.remove(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$index dismissed')));
                  },
                  child: Container(
                      constraints:  const BoxConstraints(
                        minWidth: 350,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: Padding(
                        padding:  const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Activity: ${model.activitys[index].activityName}'),
                            Text('Link: ${model.activitys[index].link}'),
                            Row(
                              children: [
                                Text(
                                    'Type: ${model.activitys[index].activityType},  '),
                                Text(
                                    'Participants: ${model.activitys[index].participants.toString()}, '),
                                Text(
                                    'Price: ${model.activitys[index].price.toString()} '),
                              ],
                            ),

                            Row(
                              children: [
                                Text('Key: ${model.activitys[index].key},  '),
                                Text(
                                    'Accessibility: ${model.activitys[index].accessibility.toString()}  '),
                              ],
                            ),
                            ],
                        ),
                      )),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
