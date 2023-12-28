import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../Model/products_model.dart';
import '../../database/local/cache_helper.dart';
import '../../database/network/dio-helper.dart';
import '../../database/network/dio_exceptions.dart';

class ProductCubit extends Cubit<ProductsMainState> {
  ProductCubit() : super(ProductsMainInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);
  List<ProductsModel> productsModelList = [];
String selectedDate=DateFormat.yMd().format(DateTime.now());
changeDate(var date){
  selectedDate=date;
  emit(state);

}
  // String token=  CacheHelper.get(key: 'token');

  Future postProduct(BuildContext context,ProductsModel productsModel) async {
    emit(AddProductsLoadingState());
    FormData formData = FormData.fromMap({
      'name': productsModel.name,
      "date": productsModel.date!,
      'length': productsModel.length,
      "address":productsModel.address,
      "amount_paid": productsModel.amountPaid,
      "chest_length": productsModel.chestLength,
      "created_at": DateTime.now(),
      "details": productsModel.details,
      'hand_length': productsModel.handLength,
      'image': productsModel.image,
      'k_length': productsModel.kLength,
      'm_length': productsModel.mLength,
      'num_dresses': productsModel.numDresses,
      "neck": productsModel.neck,
      "phone": productsModel.phone,
      "prize": productsModel.prize,
      "Remaining_amount": productsModel.remainingAmount,
      "user_id": productsModel.userId,

    });
    try {
      await Dio()
          .post("https://panicky-boa-garment.cyclic.app/products",
          data: formData)


          .then((value) {
        if (value.statusCode == 200) {
          ProductsModel responseBody ;

      responseBody=   ProductsModel.fromJson(value.data);
          print(responseBody.address);


          Toast.show("تم الاضافة بنجاح ", duration: Toast.lengthLong, gravity:  Toast.bottom);

          emit(AddProductsSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'], duration: Toast.lengthLong, gravity:  Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddProductsErrorState(e));

      throw errorMessage;
    }
  }
  Future getData() async {
  productsModelList=[];
    emit(GetProductsLoadingState());

    try {
      await Dio()
          .get("https://panicky-boa-garment.cyclic.app/products",
           ).then((value) {
        if (value.statusCode == 200) {
        productsModelList=  (value.data as List).map((e) => ProductsModel.fromJson(e)).toList();
        print(productsModelList);

          emit(AddProductsSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'], duration: Toast.lengthLong, gravity:  Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddProductsErrorState(e));

      throw errorMessage;
    }
  }
  Future deleteProduct(String id) async {
    emit(GetProductsLoadingState());

    try {
      await Dio()
          .delete("https://panicky-boa-garment.cyclic.app/products/$id",
      ).then((value) {
        if (value.statusCode == 200) {
          getData();
          Toast.show("تم الحذف بنجاح", duration: Toast.lengthLong, gravity:  Toast.bottom);

          emit(AddProductsSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'], duration: Toast.lengthLong, gravity:  Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddProductsErrorState(e));

      throw errorMessage;
    }
  }

// Future subCategory(String id,
//     BuildContext context) async {
//   emit(SubCLoadingState());
//   try {
//     var response = await DioHelper.postData(
//         url: 'supcategory/$id', data: {},token: token
//     );
//     if (response.statusCode == 200) {
//
//       var responseBody = response.data['data'];
//       print(response.data['message']);
//       subCategoryList=
//           (responseBody as List).map((e) => SubData.fromJson(e)).toList();
//       emit(SubCSuccessState());
//
//     }
//
//   } on DioError catch (e) {
//     print(e.response!.data);
//     final errorMessage = DioExceptions.fromDioError(e).toString();
//     showToast(message: errorMessage, color: Colors.red);
//     emit(SubCErrorState(e));
//
//     throw errorMessage;
//
//   }
// }
// Future Product(
//     String id,
//     BuildContext context) async {
//   emit(ProductLoadingState());
//   try {
//     var response = await DioHelper.postData(
//         url: 'product/$id', data: {},token: token
//     );
//     if (response.statusCode == 200) {
//
//       var responseBody = response.data['data'];
//       print(response.data['message']);
//       productList=
//           (responseBody as List).map((e) => ProductData.fromJson(e)).toList();
//       emit(ProductSuccessState());
//
//     }
//
//   } on DioError catch (e) {
//     print(e.response!.data);
//     final errorMessage = DioExceptions.fromDioError(e).toString();
//     showToast(message: errorMessage, color: Colors.red);
//     emit(ProductErrorState(e));
//
//     throw errorMessage;
//
//   }
// }
}