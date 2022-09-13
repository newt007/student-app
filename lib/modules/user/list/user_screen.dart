import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/config/app_themes.dart';
import 'package:movie_db/modules/user/add/add_screen.dart';
import 'package:movie_db/modules/user/delete/bloc/delete_bloc.dart';
import 'package:movie_db/modules/user/delete/bloc/delete_event.dart';
import 'package:movie_db/modules/user/delete/bloc/delete_state.dart';
import 'package:movie_db/modules/user/detail/bloc/detail_user_state.dart';
import 'package:movie_db/modules/user/detail/detail_user_screen.dart';
import 'package:movie_db/modules/user/list/bloc/user_event.dart';
import 'package:movie_db/modules/user/list/bloc/user_state.dart';
import 'package:movie_db/utils/utils.dart';

import 'bloc/user_bloc.dart';
import 'model/get_user_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserBloc _userBloc;
  late DeleteBloc _deleteUsersBloc;

  bool isSelectedMode = false;
  Map<int, bool> selectedFlag = {};

  late List<Datum> studentList;
  List<int> idList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBloc = UserBloc();
    _userBloc.add(GetListUserEvent());

    _deleteUsersBloc = DeleteBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Mahasiswa"),
        actions: [
          isSelectedMode
              ? IconButton(
                  onPressed: () {
                    idList.clear();
                    var map = Map.from(selectedFlag)
                      ..removeWhere((key, value) => value == false);
                    map.keys.forEach((element) {
                      idList.add(studentList[element].id);
                    });
                    showAlertDialog(() {
                      _deleteUsersBloc.add(MultipleDeleteUserEvent(idList));
                    }, () {});
                  },
                  icon: Icon(Icons.delete))
              : Container()
        ],
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddScreen.routeName,
            arguments: emptyData,
          ).then(
            (value) => {_userBloc.add(GetListUserEvent())},
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => _userBloc),
        BlocProvider<DeleteBloc>(create: (context) => _deleteUsersBloc)
      ],
      child: BlocListener<DeleteBloc, DeleteState>(
        listener: (context, state) {
          if (state is DeleteSuccess) {
            _userBloc.add(GetListUserEvent());
            selectedFlag.clear();
            setState(() {
              isSelectedMode = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppThemes.colorPrimary,
                content: Text('Data berhasil dihapus'),
              ),
            );
            Navigator.pop(context);
          }
        },
        child: BlocBuilder(
          bloc: _userBloc,
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is UserSuccess) {
              studentList = state.response.data;
              return _buildStudentList(state.response.data);
            }
            if (state is UserFailure) {
              print(state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildStudentList(List<Datum> students) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          selectedFlag[index] = selectedFlag[index] ?? false;
          bool? isSelected = selectedFlag[index];
          return Card(
            child: ListTile(
              onLongPress: () => onLongPress(isSelected, index),
              onTap: () => onTap(isSelected, index, students),
              title: Text(
                "Nama : ${students[index].name}",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text("Umur : ${students[index].umur}"),
              trailing: SizedBox(
                  width: 50, height: 50, child: _buildSelectIcon(isSelected!)),
            ),
          );
        },
      ),
    );
  }

  void onTap(bool isSelected, int index, List<Datum> students) {
    if (isSelectedMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        isSelectedMode = selectedFlag.containsValue(true);
        print(Map.from(selectedFlag)
          ..removeWhere((key, value) => value == false));
      });
    } else {
      Navigator.pushNamed(
        context,
        DetailUserScreen.routeName,
        arguments: students[index].id,
      ).then(
        (value) => {_userBloc.add(GetListUserEvent())},
      );
    }
  }

  void onLongPress(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      isSelectedMode = selectedFlag.containsValue(true);
    });
  }

  Widget _buildSelectIcon(bool isSelected) {
    if (isSelectedMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return Container();
    }
  }

  showAlertDialog(Function positiveButton, Function negativeButton) {
    Widget cancelButton = ElevatedButton(
        child: Text("Cancel"),
        onPressed: () {
          negativeButton();
        });

    Widget continueButton = ElevatedButton(
        child: Text("Yakin"),
        onPressed: () {
          positiveButton();
        });
    AlertDialog alert = AlertDialog(
      title: Text("Informasi"),
      content: Text("Apakah anda yakin ingin menghapus data siswa ini ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }
}
