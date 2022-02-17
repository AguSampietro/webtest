part of 'producto_cubit.dart';

class ProductoState extends Equatable {
  const ProductoState();

  @override
  List<Object> get props => [];
}

class ProductoInitial extends ProductoState {
  const ProductoInitial();
}

class ProductoLoading extends ProductoState {
  const ProductoLoading();
}

class ProductoLoaded extends ProductoState {
  final List<Producto> productos;

  const ProductoLoaded({required this.productos});

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductoLoaded && other.productos == productos;
  }

  @override
  int get hashCode => productos.hashCode;
  // END Generated class
}

class ProductoError extends ProductoState {
  final String message;
  const ProductoError(this.message);

  // Generated class
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductoError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
  // END Generated class
}
