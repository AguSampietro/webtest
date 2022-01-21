part of 'registro_detalle_cubit.dart';

class RegistroDetalleState extends Equatable {
  const RegistroDetalleState();

  @override
  List<Object> get props => [];
}

class RegistroDetalleInitial extends RegistroDetalleState {
  const RegistroDetalleInitial();
}

class RegistroDetalleLoading extends RegistroDetalleState {
  const RegistroDetalleLoading();
}

class RegistroDetalleLoaded extends RegistroDetalleState {
  final RegistroProduccion registro;

  const RegistroDetalleLoaded({required this.registro});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistroDetalleLoaded && other.registro == registro;
  }

  @override
  int get hashCode => registro.hashCode;
  // END Generated class
}

class RegistroDetalleError extends RegistroDetalleState {
  final String message;
  const RegistroDetalleError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistroDetalleError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
