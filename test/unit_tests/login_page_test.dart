import 'package:FlutterApp06/Frontend/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

//create firebase auth mock
class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class AuthResultMock extends Mock implements AuthResult {}

class FirebaseUserMock extends Mock implements FirebaseUser {}

//every dart program starts with a main function like below
//in VS code the debug just below runs just this test
main() {
  //instantiating mocks
  FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
  AuthResultMock authResultMock = AuthResultMock();
  FirebaseUserMock firebaseUserMock = FirebaseUserMock();

  //create test group for organisation and clarity
  group("Login page unit test | ", () {
    test('signin calls auth sign in with email method', () async {
      //instantiate class
      final state = MyLoginPageState();

      //set auth to mock representation of firebase auth
      state.auth = firebaseAuthMock;

      //tell the mock what to return when external api (firebase auth) properties are called
      //the below methods/properties correspond to login method in view.
      when(firebaseAuthMock.signInWithEmailAndPassword(
        email: "test",
        password: "test",
      )).thenAnswer((realInvocation) => Future.value(authResultMock));
      when(authResultMock.user).thenReturn(firebaseUserMock);
      when(firebaseUserMock.uid).thenReturn("test");

      state.email = TextEditingController(text: "test");
      state.password = TextEditingController(text: "test");

      //call and await method onPressed.
      final result = await state.signIn();

      //check that firebase auth api sign in method was called once.
      verify(firebaseAuthMock.signInWithEmailAndPassword(
        email: "test",
        password: "test",
      )).called(1);
      //mock api returned the value we set above
      expect(result.user.uid, "test");
    });
  });
}
