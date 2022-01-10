part of 'maquina_cubit.dart';

class MaquinaState extends Equatable {
  const MaquinaState();

  @override
  List<Object> get props => [];
}

class MaquinaInitial extends MaquinaState {
  const MaquinaInitial();
}

class MaquinaLoading extends MaquinaState {
  const MaquinaLoading();
}

class MaquinaLoaded extends MaquinaState {
  final List<Maquina> maquinas;

  const MaquinaLoaded({required this.maquinas});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MaquinaLoaded && other.maquinas == maquinas;
  }

  @override
  int get hashCode => maquinas.hashCode;
  // END Generated class
}

class MaquinaError extends MaquinaState {
  final String message;
  const MaquinaError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MaquinaError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
