import 'dart:developer';

import 'package:flutter_assessment/app/data/local/preference/pref_manager.dart';
import 'package:flutter_assessment/app/data/local/preference/pref_manager_impl.dart';
import 'package:flutter_assessment/app/data/remote/login/login_remote_source.dart';
import 'package:flutter_assessment/app/data/remote/login/login_remote_source_impl.dart';
import 'package:flutter_assessment/app/data/remote/signup/signup_remote_source.dart';
import 'package:flutter_assessment/app/data/remote/signup/signup_remote_source_impl.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/user_update_remote_source.dart';
import 'package:flutter_assessment/app/data/remote/user%20update/user_update_remote_source_impl.dart';
import 'package:flutter_assessment/app/data/repository/login/login_repository.dart';
import 'package:flutter_assessment/app/data/repository/login/login_repository_impl.dart';
import 'package:flutter_assessment/app/data/repository/signup/signup_repository.dart';
import 'package:flutter_assessment/app/data/repository/signup/signup_repository_impl.dart';
import 'package:flutter_assessment/app/data/repository/user%20update/user_update_repository.dart';
import 'package:flutter_assessment/app/data/repository/user%20update/user_update_repository_impl.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  static Future<void> setUpServiceLocator() async {
    serviceLocator.registerLazySingleton<PrefManager>(() => PrefManagerImpl());

    serviceLocator.registerLazySingleton<LoginRemoteSource>(
        () => LoginRemoteSourceImpl());

    serviceLocator.registerLazySingleton<SignupRemoteSource>(
        () => SignupRemoteSourceImpl());

    serviceLocator.registerLazySingleton<UserUpdateRemoteSource>(
        () => UserUpdateRemoteSourceImpl());

    serviceLocator.registerLazySingleton<LoginRepository>(() =>
        LoginRepositoryImpl(remoteSource: serviceLocator<LoginRemoteSource>()));

    serviceLocator.registerLazySingleton<SignupRepository>(() =>
        SignupRepositoryImpl(
            remoteSource: serviceLocator<SignupRemoteSource>()));

    serviceLocator.registerLazySingleton<UserUpdateRepository>(() =>
        UserUpdateRepositoryImpl(
            remoteSource: serviceLocator<UserUpdateRemoteSource>()));
  }
}
