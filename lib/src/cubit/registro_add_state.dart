part of 'registro_add_cubit.dart';

class RegistroAddState extends Equatable {
  const RegistroAddState();

  @override
  List<Object> get props => [];
}

class RegistroAddInitial extends RegistroAddState {
  const RegistroAddInitial();
}

class RegistroAddLoading extends RegistroAddState {
  const RegistroAddLoading();
}

class RegistroAddLoaded extends RegistroAddState {
  final String mensaje;
  final bool error;

  RegistroAddLoaded({required this.mensaje, required this.error});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistroAddLoaded && other.mensaje == mensaje;
  }

  @override
  int get hashCode => mensaje.hashCode;
  // END Generated class
}

class RegistroAddError extends RegistroAddState {
  final String message;
  const RegistroAddError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistroAddError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
