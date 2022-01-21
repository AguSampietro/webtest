part of 'registro_lista_cubit.dart';

class RegistroListaState extends Equatable {
  const RegistroListaState();

  @override
  List<Object> get props => [];
}

class RegistroListaInitial extends RegistroListaState {
  const RegistroListaInitial();
}

class RegistroListaLoading extends RegistroListaState {
  const RegistroListaLoading();
}

class RegistroListaLoaded extends RegistroListaState {
  final List<RegistroLista> registros;

  const RegistroListaLoaded({required this.registros});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistroListaLoaded && other.registros == registros;
  }

  @override
  int get hashCode => registros.hashCode;
  // END Generated class
}

class RegistroListaError extends RegistroListaState {
  final String message;
  const RegistroListaError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistroListaError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
