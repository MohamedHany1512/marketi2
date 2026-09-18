import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/profile/data/repos/profile_repo.dart';
import 'package:marketi/features/profile/presentation/view_model/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitialState());

  void getProfile() async {
    emit(ProfileLoadingState());
    final result = await profileRepo.getProfileData();
    result.fold(
      (error) => emit(ProfileErrorState(error)),
      (profile) => emit(ProfileSuccessState(profile)),
    );
  }
}