part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  final Usuario usuario;

  const LoginLoaded({required this.usuario});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginLoaded && other.usuario == usuario;
  }

  @override
  int get hashCode => usuario.hashCode;
  // END Generated class
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
