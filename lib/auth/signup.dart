import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_firebase_authentication/mvc/state/auth_store.dart';

class FirebaseAuthSignUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer <AuthStore>(
      builder: (context, authStore, _) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            title: Text(
              "会員登録",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black54
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.stadium(),
                      depth: -8
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12.0),
                        labelText: "メールアドレス",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black54,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String value) {
                        authStore.changeEmail(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Neumorphic(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.stadium(),
                      depth: -8
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12.0),
                        labelText: "パスワード(6文字以上)",
                        prefixIcon: Icon(
                          Icons.vpn_key_rounded,
                          color: Colors.black54,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (String value) {
                        authStore.changePassword(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  NeumorphicButton(
                    child: Text(
                      "ユーザー登録",
                      style: TextStyle(
                        color:      Colors.blue,
                        fontSize:   16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 16, left: 104, bottom: 16, right: 104),
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.stadium(),
                      depth: 8
                    ),
                    onPressed: () async {
                      try {
                        authStore.changeLoading(true);
                        final UserCredential result = await authStore.signUp();

                        final User user = result.user!;
                        await authStore.setUser(user);

                        authStore.changeLoading(false);
                      } catch (e) {
                        authStore.changeLoading(false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
