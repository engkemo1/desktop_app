import 'package:bloc/bloc.dart';
import 'package:desktop_app/view/screens/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import '../../../view/widgets/component.dart';
import '../../database/network/dio-helper.dart';
import '../../database/network/end_points.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<LoginMainState> {
  LoginCubit() : super(LoginMainInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future login(
      String userName, String password, BuildContext context,  ) async {
    ToastContext().init(context);

    emit(LoginLoadingState());
    try {
      var response = await DioHelper.postData(
          url:"https://node-mongo-dn.onrender.com/products/login", data: {'userName': userName, 'password': password});
      if (response.statusCode==200) {
        print(response.statusCode.toString());
        print(response.data.toString());

        navigator(context, MainScreen());
        emit(LoginSuccessState());
      } else {
        Toast.show("Authentication failed \n password or name is incorrect", duration: Toast.lengthShort, gravity:  Toast.bottom);
      }
    } on DioError catch (e) {
      print(e.error);
      Toast.show(" password or name is incorrect", duration: Toast.lengthShort, gravity:  Toast.bottom);

      // Toast.show(e.response!.data["data"]['errors'].toString(), duration: Toast.lengthLong, gravity:  Toast.bottom);

      emit(LoginErrorState(e));
    }
  }
}
