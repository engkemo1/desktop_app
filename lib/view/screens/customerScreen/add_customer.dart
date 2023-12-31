import 'dart:ui' as ui;
import 'package:desktop_app/view_model/cubit/customer_cubit/customer_state.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customers_cubit.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../Model/customer_model.dart';
import '../../../Model/products_model.dart';
import '../../../constants.dart';
import '../../widgets/customTextField.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController prizeController = TextEditingController();
  TextEditingController remainingAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Desktop(),
    );
  }

  Directionality Desktop() {
    var width = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_reaction,
                      size: 100,
                      color: accentCanvasColor,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'اضافة عميل',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: isSmallScreen ? null : 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'الاسم',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            CustomTextField(
                              controller: nameController,
                              isFormField: true,
                              hintText: 'ادخل الاسم ',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isSmallScreen ? null : 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'رقم الهاتف',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            CustomTextField(
                              controller: phoneController,
                              isPhoneNumber: true,
                              textInputType: TextInputType.phone,
                              hintText: 'ادخل رقم الهاتف',
                              isFormField: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isSmallScreen ? null : 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'العنوان',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            CustomTextField(
                              controller: addressController,
                              textInputType: TextInputType.streetAddress,
                              isFormField: true,
                              hintText: 'ادخل العنوان ',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: 150,
                        child: BlocProvider(
                            create: (context) => CustomersCubit(),
                            child: BlocConsumer<CustomersCubit,
                                    CustomersMainState>(
                                listener: (BuildContext context, state) async {
                              if (state is AddCustomersLoadingState) {
                                SmartDialog.showLoading();
                                await Future.delayed(Duration(seconds: 2));
                                SmartDialog.dismiss();
                              }
                            }, builder: (BuildContext context, state) {
                              return ElevatedButton(

                                onPressed: () {

                                  var customer = Customer(
                                      userName: nameController.text,
                                      phone: phoneController.text,
                                      address: addressController.text,
                                      remainingAmount: 0);
                                  print(customer.userName);

                                  if(_formKey.currentState!.validate()){
                                    CustomersCubit.get(context)
                                        .postCustomer(context, customer).then((value) {
                                          nameController.clear();
                                          phoneController.clear();
                                          addressController.clear();
                                    });
                                  }

                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        accentCanvasColor)),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            })))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
