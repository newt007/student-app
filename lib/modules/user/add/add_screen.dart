import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/config/app_themes.dart';
import 'package:movie_db/modules/user/add/bloc/add_bloc.dart';
import 'package:movie_db/modules/user/add/bloc/add_event.dart';
import 'package:movie_db/modules/user/add/bloc/add_state.dart';
import 'package:movie_db/modules/user/edit/bloc/edit_bloc.dart';
import 'package:movie_db/modules/user/edit/bloc/edit_event.dart';
import 'package:movie_db/modules/user/edit/bloc/edit_state.dart';

import '../detail/model/detail_user_response.dart';

class AddScreen extends StatefulWidget {
  AddScreen(this.user);

  final Data user;
  static const String routeName = "/addScreenRoute";

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late AddBloc _addBloc = AddBloc();
  late EditBloc _editBloc = EditBloc();

  late TextEditingController _nameController;
  late TextEditingController _ageController;

  final _formKey = GlobalKey<FormState>();

  late bool isSubmitLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();

    if (widget.user.name != null && widget.user.umur != null) {
      _nameController.text = widget.user.name;
      _ageController.text = widget.user.umur.toString();
    }

    _addBloc = AddBloc();
    _editBloc = EditBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.user.name == null
            ? Text("Data Baru")
            : Text("Perbarui Data"),
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
          BlocProvider<AddBloc>(create: (context) => _addBloc),
          BlocProvider<EditBloc>(create: (context) => _editBloc),
        ],
        child: widget.user.id == null
            ? _buildAddSectionBuilder()
            : _buildEditSectionBuilder());
  }

  Widget _buildAddSectionBuilder() {
    return BlocListener<AddBloc, AddState>(
      listener: (context, state) {
        if (state is ShowLoadingAddState) {
          print(state);
          setState(() {
            isSubmitLoading = true;
          });
        }
        if (state is ShowResultAddState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppThemes.colorPrimary,
              content: Text('Data berhasil ditambahkan'),
            ),
          );
        }
      },
      child: BlocBuilder<AddBloc, AddState>(
        bloc: _addBloc,
        builder: (context, state) {
          return _buildInitialLayout();
        },
      ),
    );
  }

  Widget _buildEditSectionBuilder() {
    return BlocListener<EditBloc, EditState>(
      listener: (context, state) {
        if (state is EditLoading) {
          setState(() {
            isSubmitLoading = true;
          });
        }
        if (state is EditSuccess) {
          if (state.response.success) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppThemes.colorPrimary,
                content: Text('Data berhasil diupdate'),
              ),
            );
          }
        }
      },
      child: BlocBuilder<EditBloc, EditState>(
        bloc: _editBloc,
        builder: (context, state) {
          if (state is EditSuccess) {
            if (state.response.success) {
              print(state.response.message);
            }
          }
          if (state is EditFailure) {
            print(state.message);
          } else {
            return _buildInitialLayout();
          }
          return _buildInitialLayout();
        },
      ),
    );
  }

  Widget _buildInitialLayout() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Nama tidak boleh kosong";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Masukkan nama anda',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _ageController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              maxLength: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Umur tidak boleh kosong";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Masukkan umur anda',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              child: isSubmitLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Text("Submit"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.user.id == null) {
                    _addBloc.add(AddNewPostEvent(
                        _nameController.text, _ageController.text));
                  } else {
                    _editBloc.add(EditUserEvent(_nameController.text,
                        _ageController.text, widget.user.id));
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
