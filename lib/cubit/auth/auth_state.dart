part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;
   AuthFailureState({required this.message});
}

class AuthSignUpState extends AuthState {
  final bool response;
  AuthSignUpState(this.response);
}

class AuthSignInState extends AuthState {
  final bool response;
  AuthSignInState(this.response);
}

