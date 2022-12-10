import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:centre_source/models/ImageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../constants/AppStrings.dart';
part 'image_list_state.dart';

class ImageListCubit extends Cubit<ImageListState> {
  ImageListCubit() : super(ImageListInitial());
  Future<void> callImageAPI(String query) async {
    emit(ImageListLoading());
    var _headers = {
      'Accept': 'application/json',
    };
    final response = await http.get(Uri.parse("${base_url+query}&image_type=photo"),
        headers:_headers);
    final res = jsonDecode(response.body);
    final imageModel= ImageModel.fromJson(res);
    emit(ImageListSuccess(imageModel: imageModel));
    print(res);
  }
}
