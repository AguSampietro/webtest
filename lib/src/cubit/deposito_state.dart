part of 'deposito_cubit.dart';

class DepositoState extends Equatable {
  const DepositoState();

  @override
  List<Object> get props => [];
}

class DepositoInitial extends DepositoState {
  const DepositoInitial();
}

class DepositoLoading extends DepositoState {
  const DepositoLoading();
}

class DepositoLoaded extends DepositoState {
  final List<Deposito> depositos;

  const DepositoLoaded({required this.depositos});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepositoLoaded && other.depositos == depositos;
  }

  @override
  int get hashCode => depositos.hashCode;
  // END Generated class
}

class DepositoError extends DepositoState {
  final String message;
  const DepositoError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepositoError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
