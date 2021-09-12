import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:money_book/logic/auth.dart';
import 'package:money_book/components/iconButtonsheet.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'HomeScreen';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff79B4B7),
          title: Text(
            "Money Book",
            style: GoogleFonts.pacifico(
              fontSize: 25.0,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconBottomSheet(
                                label: 'Update Profile',
                                onPress: () {
                                  Navigator.pop(context, 'close');
                                },
                                icon: Icons.account_circle,
                              ),
                              IconBottomSheet(
                                  label: 'Sign Out',
                                  onPress: () async {
                                    await _auth.logOut();
                                    Navigator.pop(context, 'close');
                                  },
                                  icon: Icons.logout)
                            ],
                          ),
                        );
                      });
                })
          ],
        ));
  }
}
