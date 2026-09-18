import 'package:marketi/features/profile/data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final ProfileModel profile;
  ProfileSuccessState(this.profile);
}

class ProfileErrorState extends ProfileState {
  final String error;
  ProfileErrorState(this.error);
}