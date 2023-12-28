abstract class ProductsMainState {}

class ProductsMainInitialState extends ProductsMainState{}
class AddProductsLoadingState extends ProductsMainState{}
class AddProductsSuccessState extends ProductsMainState{}

class AddProductsErrorState extends ProductsMainState{
  final  error;

  AddProductsErrorState(this.error);
}
class GetProductsLoadingState extends ProductsMainState{}
class  GetProductsSuccessState extends ProductsMainState{}

class  GetProductsErrorState extends ProductsMainState{
  final  error;

  GetProductsErrorState(this.error);
}
class DeleteProductsLoadingState extends ProductsMainState{}
class  DeleteProductsSuccessState extends ProductsMainState{}

class  DeleteProductsErrorState extends ProductsMainState{
  final  error;

  DeleteProductsErrorState(this.error);
}
