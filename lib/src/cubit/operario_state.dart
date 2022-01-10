part of 'operario_cubit.dart';

class OperarioState extends Equatable {
  const OperarioState();

  @override
  List<Object> get props => [];
}

class OperarioInitial extends OperarioState {
  const OperarioInitial();
}

class OperarioLoading extends OperarioState {
  const OperarioLoading();
}

class OperarioLoaded extends OperarioState {
  final List<Operario> operarios;

  const OperarioLoaded({required this.operarios});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OperarioLoaded && other.operarios == operarios;
  }

  @override
  int get hashCode => operarios.hashCode;
  // END Generated class
}

class OperarioError extends OperarioState {
  final String message;
  const OperarioError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OperarioError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
