part of 'fallo_cubit.dart';

class FalloState extends Equatable {
  const FalloState();

  @override
  List<Object> get props => [];
}

class FalloInitial extends FalloState {
  const FalloInitial();
}

class FalloLoading extends FalloState {
  const FalloLoading();
}

class FalloLoaded extends FalloState {
  final List<Fallo> fallos;

  const FalloLoaded({required this.fallos});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FalloLoaded && other.fallos == fallos;
  }

  @override
  int get hashCode => fallos.hashCode;
  // END Generated class
}

class FalloError extends FalloState {
  final String message;
  const FalloError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FalloError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
