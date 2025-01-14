import 'package:bird_system/cubit/cubit.dart';
import 'package:bird_system/cubit/states.dart';
import 'package:bird_system/reusable/reusable_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_user.dart';

// ignore: must_be_immutable
class UserScreen extends StatelessWidget {
  late int userIndex;

  UserScreen(int indexUser, {Key? key}) : super(key: key) {
    userIndex = indexUser;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                if (cubit.userData['ID'].toString().isNotEmpty || true) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditUserScreen(cubit.userData['ID'], true);
                  }));
                }
              }),
          appBar: AppBar(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            title: Text(
              'User Information',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: [
              state is DeleteEmployeeLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoActivityIndicator(),
                    )
                  : IconButton(
                      onPressed: () {
                        cubit.deleteEmployee(userIndex, context);
                      },
                      icon: Icon(Icons.restore_from_trash_outlined))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: customGreen,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'images/vector.png',
                              imageErrorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: Image.asset('images/vector.png'),
                                  ),
                                );
                              },
                              image: cubit.driveToImage(
                                  '${cubit.userData['ImageLink']}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${cubit.userData['Name']}',
                      style: TextStyle(
                          color: customGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "ID : ${cubit.userData['ID']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(children: [
                    Text(
                      'Person role : ',
                      style: TextStyle(
                        color: customGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SelectableText(
                      '${cubit.userData['PersonRole']}',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(children: [
                    Text(
                      'Person Phone : ',
                      style: TextStyle(
                        color: customGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SelectableText(
                      '+20${cubit.userData['Phone']}',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'Registration States',
                      style: TextStyle(
                          color: customGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: cubit.userData.isEmpty
                          ? 0
                          : 60 * (cubit.userData.length - 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView.separated(
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (cubit.userData.keys
                                .toList()[index]
                                .toString()
                                .contains("Date-")) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                      cubit.userData.keys
                                          .toList()[index]
                                          .toString()
                                          .replaceAll('Date-', ''),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ))),
                                    Expanded(
                                      child: Center(
                                        child: cubit.userData.values
                                                .toList()[index]
                                                .toString()
                                                .contains('Time-')
                                            ? Icon(
                                                Icons.check,
                                                size: 35,
                                                color: Colors.green,
                                              )
                                            : Text(
                                                'X',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox();
                          },
                          itemCount: cubit.userData.length),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
