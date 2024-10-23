import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:el_vaso/utilities/enums/theme_state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../config/local_storage/local_storage.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> with ChangeNotifier {
  final LocalStorage _localStorage;

  ConfigCubit({
    required LocalStorage localStorage,
  })  : _localStorage = localStorage,
        super(const ConfigState()) {
    _onCheckTheme();
  }

  void _onCheckTheme() {
    if (_localStorage.theme.isEmpty) {
      emit(state.copyWith(themeState: ThemeState.lightTheme));
    } else {
      emit(state.copyWith(
          themeState: _localStorage.theme == 'light'
              ? ThemeState.lightTheme
              : ThemeState.darkTheme));
    }

    log('ThemeSelct:${state.themeState} LocalTheme:${_localStorage.theme}');
  }

///////////////////////////////////////////////////
///////////////////////////////////////////////////////
  void onChangeTheme() {
    if (state.themeState == ThemeState.lightTheme) {
      emit(state.copyWith(themeState: ThemeState.darkTheme));
      _localStorage.theme = 'dark';
    } else {
      emit(state.copyWith(themeState: ThemeState.lightTheme));
      _localStorage.theme = 'light';
    }
  }
}
