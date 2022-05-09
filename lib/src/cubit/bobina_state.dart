part of 'bobina_cubit.dart';

class BobinaState extends Equatable {
  const BobinaState();

  @override
  List<Object> get props => [];
}

class BobinaInitial extends BobinaState {
  const BobinaInitial();
}

class BobinaLoading extends BobinaState {
  const BobinaLoading();
}

class BobinaLoaded extends BobinaState {
  final List<Bobina>? bobinas;
  final List<Bobina>? bobinasPorDeposito;
  final List<NroSerie>? bobinasNroSerie;

  const BobinaLoaded({
    this.bobinas,
    this.bobinasPorDeposito,
    this.bobinasNroSerie,
  });

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BobinaLoaded && other.bobinas == bobinas;
  }

  @override
  int get hashCode => bobinas.hashCode;
  // END Generated class
}

class BobinaError extends BobinaState {
  final String message;
  const BobinaError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BobinaError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
