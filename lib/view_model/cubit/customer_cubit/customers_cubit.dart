import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:desktop_app/view/screens/customerScreen/add_customer.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../Model/customer_model.dart';
import '../../../Model/products_model.dart';
import '../../database/local/cache_helper.dart';
import '../../database/network/dio-helper.dart';
import '../../database/network/dio_exceptions.dart';
import 'customer_state.dart';

class CustomersCubit extends Cubit<CustomersMainState> {
  CustomersCubit() : super(CustomersMainInitialState());

  static CustomersCubit get(context) => BlocProvider.of(context);
  List<Customer> customerModelList = [];


  Future postCustomer(BuildContext context,Customer customerModel) async {
    print(customerModel.address);
    ToastContext().init(context);

    emit(AddCustomersLoadingState());

    try {
print(customerModel.toJson());
await Dio()
          .post("https://panicky-boa-garment.cyclic.app/products/customers",
            data: {
    'userName': customerModel.userName,
    "address":customerModel.address,
    "phone": customerModel.phone,
    "Remaining_amount": customerModel.remainingAmount,

    })


          .then((value) {
        if (value.statusCode == 200) {
          Toast.show("تم الاضافة بنجاح ", duration: Toast.lengthLong, gravity:  Toast.bottom);

          emit(AddCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'], duration: Toast.lengthLong, gravity:  Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(AddCustomersErrorState(e));

      throw errorMessage;
    }
  }
  Future updateCustomer(BuildContext context,Customer customerModel,String id) async {
    print(customerModel.address);
    ToastContext().init(context);

    emit(UpdateCustomersLoadingState());

    try {
      print(customerModel.toJson());
      await Dio()
          .put("https://panicky-boa-garment.cyclic.app/products/customers/$id",
          data: {
            'userName': customerModel.userName,
            "address":customerModel.address,
            "phone": customerModel.phone,
            "Remaining_amount": customerModel.remainingAmount,

          })


          .then((value) {
        if (value.statusCode == 200) {
          Toast.show("تم التحديث بنجاح ", duration: Toast.lengthLong, gravity:  Toast.bottom);

          emit(UpdateCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'], duration: Toast.lengthLong, gravity:  Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(UpdateCustomersErrorState(e));

      throw errorMessage;
    }
  }

  Future getData() async {
  customerModelList=[];
    emit(GetCustomersLoadingState());

    try {
      await Dio()
          .get("https://panicky-boa-garment.cyclic.app/products/customers",
           ).then((value) {
        if (value.statusCode == 200) {
        customerModelList=  (value.data as List).map((e) => Customer.fromJson(e)).toList();
        print(customerModelList);

          emit(GetCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'], duration: Toast.lengthLong, gravity:  Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(GetCustomersErrorState(e));

      throw errorMessage;
    }
  }
  Future deleteCustomer(String id) async {
    emit(DeleteCustomersLoadingState());

    try {
      await Dio()
          .delete("https://panicky-boa-garment.cyclic.app/products/customers/$id",
      ).then((value) {
        if (value.statusCode == 200) {
          getData();
          Toast.show("تم الحذف بنجاح", duration: Toast.lengthLong, gravity:  Toast.bottom);

          emit(DeleteCustomersSuccessState());
        }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Toast.show(e.response!.data['message'], duration: Toast.lengthLong, gravity:  Toast.bottom);

      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(DeleteCustomersErrorState(e));

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