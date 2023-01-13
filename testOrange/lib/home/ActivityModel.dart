import 'package:flutter/material.dart';

import 'ActivityItem.dart';
class Activity extends ChangeNotifier{
  final List<ActivityItem> _activitys =[];
  List<ActivityItem> get activitys => _activitys;

   void add(ActivityItem _activity){
     _activitys.add(_activity);
   }
void remove(int index){
     _activitys.removeAt(index);
}
void update(int oldIndex, int newIndex){

   final tile =_activitys.removeAt(oldIndex);
   _activitys.insert(newIndex, tile);

}
}