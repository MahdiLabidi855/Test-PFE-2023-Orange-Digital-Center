import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testorange/home/ActivityItem.dart';
import 'package:testorange/home/ActivityModel.dart';
import 'package:testorange/home/bloc/home_bloc.dart';
import 'package:testorange/services/boredService.dart';
import 'package:testorange/services/connectivityService.dart';
import '../Get/Text.dart';
import 'favoritesActivity.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loadApiEventBool = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Activity>(builder: (context, model, child) {
      return BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<BoredService>(context),
          RepositoryProvider.of<ConnectivityService>(context),
        )..add(LoadApiEvent()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
                child: Image.asset(
              "Assets/Images/BoringFace.png",
              height: 40,
              width: 40,
            )),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
                right: 48.0, left: 20, top: 60, bottom: 10),
            child: Row(
              children: [
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return FloatingActionButton(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black, width: 1)),
                    child: const FaIcon(
                      FontAwesomeIcons.xmark,
                      size: 30,
                      color: Color(0xffff5e51),
                    ),
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(LoadApiEvent());
                    },
                  );
                }),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  mini: true,
                  shape: const StadiumBorder(
                      side: BorderSide(color: Colors.black, width: 1)),
                  child: const FaIcon(FontAwesomeIcons.solidStar,
                      size: 15, color: Color(0xff07a6ff)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Favorite()),
                    );
                  },
                ),
                const Spacer(),
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return FloatingActionButton(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black, width: 1)),
                    child: const FaIcon(
                      FontAwesomeIcons.solidHeart,
                      size: 30,
                      color: Color(0xff00d387),
                    ),
                    onPressed: () {
                      if (state is HomeLoadedState) {
                        ActivityItem _newActivity = ActivityItem(
                            state.accessibility,
                            state.activityType,
                            state.participants,
                            state.price,
                            state.link,
                            state.key,
                            state.activityName);
                        model.add(_newActivity);
                      }BlocProvider.of<HomeBloc>(context).add(LoadApiEvent());
                    },
                  );
                })
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
          body: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 90),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 500,
                minWidth: 350,
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0x66D6D6D6),
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is HomeLoadedState) {
                    return Swipable(
                      onSwipeLeft: ((finalPosition) { BlocProvider.of<HomeBloc>(context).add(LoadApiEvent());
                      }),
                    onSwipeRight: ((finalPosition) { if (state is HomeLoadedState) {
                      ActivityItem _newActivity = ActivityItem(
                          state.accessibility,
                          state.activityType,
                          state.participants,
                          state.price,
                          state.link,
                          state.key,
                          state.activityName);
                      model.add(_newActivity);
                    }BlocProvider.of<HomeBloc>(context).add(LoadApiEvent());
                    }),
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 50,
                        minWidth: 350,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0,top: 30),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            TextA(
                              text: 'Activity: ',
                              titre: true,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                Expanded(
                                  child: TextA(
                                    text: state.activityName,
                                    titre: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextA(
                              text: 'Type: ',
                              titre: true,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                TextA(
                                  text: state.activityType,
                                  titre: false,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextA(
                              text: 'Participants: ',
                              titre: true,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                TextA(
                                  text: state.participants.toString(),
                                  titre: false,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextA(
                              text: 'Price: ',
                              titre: true,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                TextA(
                                  text: state.price.toString(),
                                  titre: false,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextA(
                              text: 'Link: ',
                              titre: true,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                Expanded(
                                  child: TextA(
                                    text: state.link,
                                    titre: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextA(
                              text: 'Key: ',
                              titre: true,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                TextA(
                                  text: state.key,
                                  titre: false,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextA(
                              text: 'Accessibility: ',
                              titre: true,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 40,
                                ),
                                TextA(
                                  text:
                                  state.accessibility.toString(),
                                  titre: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    );
                  }
                  if (state is HomeNoInternetState) {
                    return const Text('no internet :(');
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
