part of 'image_list_cubit.dart';

@immutable
class ImageListState {
}

class ImageListInitial extends ImageListState {

}
class ImageListLoading extends ImageListState {}
class ImageListSuccess extends ImageListState {
  ImageModel? imageModel;
  ImageListSuccess({this.imageModel});
}
