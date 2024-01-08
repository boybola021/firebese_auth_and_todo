import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../services/auth_service.dart';
import '../../services/strings.dart';
import '../../services/util.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<bool> signUp(
      {required String username,
        required String email,
        required String password,
        required String prePassword})async{
    emit(AuthLoadingState());
    try{
      if(Util.validateRegistration(username, email, password, prePassword)){
        final response = await AuthService.signUp(email, password,username);
        emit(AuthSignUpState(response));
        return response;
      }
    }catch(e){
      emit(AuthFailureState(message: I18N.somethingError));
      return false;
    }
    return false;
  }

  Future<bool> signIn({ required String email, required String password,})async{
    emit(AuthLoadingState());
    try{
      final response = await AuthService.signIn(email, password);
      emit(AuthSignInState(response));
      return response;
    }catch(e){
      emit( AuthFailureState(message: I18N.somethingError));
      return false;
    }
  }
}
