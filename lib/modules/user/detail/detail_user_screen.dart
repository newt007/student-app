import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/config/app_themes.dart';
import 'package:movie_db/modules/user/add/add_screen.dart';
import 'package:movie_db/modules/user/detail/bloc/detail_user_bloc.dart';
import 'package:movie_db/modules/user/detail/bloc/detail_user_event.dart';
import 'package:movie_db/modules/user/detail/bloc/detail_user_state.dart';
import 'package:movie_db/modules/user/detail/model/detail_user_response.dart';

class DetailUserScreen extends StatefulWidget {
  const DetailUserScreen(this.userId);

  final int userId;

  static const String routeName = "/detailScreenRoute";

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  late DetailUserBloc _detailUserBloc;
  late DetailUserBloc _deleteUserBloc;

  late Data userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _detailUserBloc = DetailUserBloc();
    _detailUserBloc.add(GetDetailUserEvent(widget.userId));

    _deleteUserBloc = DetailUserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail User"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.pushNamed(context, AddScreen.routeName,
              arguments: userData).then((value) =>
              _detailUserBloc.add(GetDetailUserEvent(widget.userId))
          );
        },
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailUserBloc>(create: (context) => _detailUserBloc)
      ],
      child: BlocListener<DetailUserBloc, DetailUserState>(
        bloc: _deleteUserBloc,
        listener: (context, state) {
          if (state is DeleteUserSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppThemes.colorPrimary,
                content: Text('Data berhasil dihapus'),
              ),
            );
          }
        },
        child: BlocBuilder<DetailUserBloc, DetailUserState>(
            bloc: _detailUserBloc,
            builder: (context, state) {
              if (state is DetailUserLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DetailUserSuccess) {
                userData = state.response.data;
                return _buildUserDetail(state.response.data);
              }
              if (state is DetailUserFailure) {
                print(state.message);
              }
              return Container();
            }),
      ),
    );
  }

  Widget _buildUserDetail(Data data) {
    return Column(
      children: [
        ListTile(
          title: Text("Nama : ${data.name}"),
          subtitle: Text("Umur : ${data.umur}"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              child: Text("Delete"),
              onPressed: () {
                showAlertDialog(() {
                  _deleteUserBloc.add(DeleteUserEvent(widget.userId));
                  Navigator.pop(context);
                }, () {});
              }),
        )
      ],
    );
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
