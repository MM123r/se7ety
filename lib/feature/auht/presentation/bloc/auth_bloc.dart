import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_123/core/enums/user_type_enum.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_event.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
    on<UpdateDoctorDataEvent>(updateDoctorData);
  }

// Login
  Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      credential.user?.photoURL;

      emit(LoginSuccessState(userType: credential.user?.photoURL ?? ""));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuhtErrorState(message: "المستخدم غير موجود"));
      } else if (e.code == 'wrong-password') {
        emit(AuhtErrorState(message: "الباسورد ضعيف"));
      } else {
        emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
      }
    } catch (e) {
      emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
    }
  }

  ///////////////////////

// Register
  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      //
      User? user = credential.user;
      await user?.updateDisplayName(event.name);

      // use photo as a user role
      await user?.updatePhotoURL(event.userType.toString());

      // store on firestore
      if (event.userType == UserType.doctor) {
        FirebaseFirestore.instance.collection("doctors").doc(user?.uid).set({
          'name': event.name,
          'image': '',
          'specialization': '',
          'rating': 3,
          'email': event.email,
          'phone1': '',
          'phone2': '',
          'bio': '',
          'openHour': '',
          'closeHour': '',
          'address': '',
          'uid': user?.uid,
        });
      } else {
        FirebaseFirestore.instance.collection("patient").doc(user?.uid).set({
          'name': event.name,
          'image': '',
          'age': '',
          'email': event.email,
          'phone': '',
          'bio': '',
          'city': '',
          'uid': user?.uid,
        });
      }

      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuhtErrorState(message: "الباسورد ضعيف"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuhtErrorState(message: "لاميل مستخدم من قيل"));
      } else {
        emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
      }
    } catch (e) {
      emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
    }
  }

  Future<void> updateDoctorData(
      UpdateDoctorDataEvent event, Emitter<AuthState> emit) async {
    emit(DoctorRegistionLoadingState());
    try {
      log("-------1-----");
      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(event.doctorModel.uid)
          .update(event.doctorModel.toJson());
          log("-------2-----");
      emit(DoctorRegistionSuccessState());
    } catch (e) {
      log("-------3-----");
      emit(AuhtErrorState(message: "حدث خطا ما يرجي محاوله مرة اخري"));
    }
  }
}
