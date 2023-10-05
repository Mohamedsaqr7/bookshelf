import 'package:bookshelf/Core/Widgets.dart';
import 'package:bookshelf/Core/colors.dart';
import 'package:bookshelf/Core/textWidgets.dart';
import 'package:bookshelf/Features/home/view/screens/orderhistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Services/Navigation.dart';
import '../../../Authentications/View/login.dart';
import '../../../Authentications/ViewModel/authcubit.dart';
import '../../../Authentications/ViewModel/authstate.dart';

class drawer extends StatelessWidget {
  Widget? accname;
  NetworkImage? accimage;
  Widget? accemail;
  drawer({required this.accname, required this.accimage,required this.accemail, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is UserlogoutsuccessState) {
            Navigation.gopushreplace(context, Login());
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPictureSize: Size(95, 88),
                  decoration: BoxDecoration(color: CustomColors.primarycolor),
                  currentAccountPicture:
                      CircleAvatar(backgroundImage: accimage),
                  accountName: accname,
                  accountEmail: accemail),
              InkWell(
                onTap: () {
                  Navigation.gopush(context, OrderHistory());
                },
                child: ListTile(
                  leading: Icon(
                    Icons.history_toggle_off_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    'order hitory',
                  ),
                ),
              ),
              sbox(h: 20),
              InkWell(
                onTap: () {
                  AuthCubit.get(context).Logout();
                },
                child: ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text(
                    'Log Out',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
