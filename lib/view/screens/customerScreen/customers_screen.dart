import 'dart:ui' as ui;
import 'package:desktop_app/constants.dart';
import 'package:desktop_app/view/screens/pdf_invoice/file_handeler.dart';
import 'package:desktop_app/view/screens/pdf_invoice/pdf.dart';
import 'package:desktop_app/view_model/cubit/customer_cubit/customers_cubit.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';

import '../../../Model/customer_model.dart';
import '../../../view_model/cubit/customer_cubit/customer_state.dart';
import '../../widgets/customTextField.dart';


class CustomerScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController prizeController = TextEditingController();
  TextEditingController remainingAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          isFormField: true,
          hintText: '  ',
        ),
        leading: const Icon(
          Icons.search,
          color: accentCanvasColor,
        ),
      ),
      body: BlocProvider(
        create: (context) => CustomersCubit()..getData(),
        child: BlocConsumer<CustomersCubit, CustomersMainState>(
            listener: (BuildContext context, state) async {
              if (state is GetCustomersLoadingState) {
                SmartDialog.showLoading();
                await Future.delayed(Duration(seconds: 2));
                SmartDialog.dismiss();
              }
            }, builder: (BuildContext context, state) {
          var data = CustomersCubit.get(context);

          return  state is GetCustomersLoadingState
              ?      const Center(
            child: CircularProgressIndicator(),
          )
              : data.customerModelList.isEmpty?
          Container(
margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: EmptyWidget(
              // Image from project assets
              image: null,
              packageImage: PackageImage.Image_3,
              title: 'No Customers',
              subTitle: 'No  Customers available yet',
              titleTextStyle:  TextStyle(
                fontSize:isSmallScreen?13:22,
                color: const Color(0xff9da9c7),
                fontWeight: FontWeight.w500,
              ),
              subtitleTextStyle:  TextStyle(
                fontSize: isSmallScreen?12:22,
                color: const Color(0xffabb8d6),
              ),
              // Uncomment below statement to hide background animation
              // hideBackgroundAnimation: true,
            ),

          ): Directionality(
              textDirection: ui.TextDirection.rtl,
              child: buildCardDesktop(
                  data,context
              ));
        }),
      ),
    );
  }



  buildCardDesktop( CustomersCubit data,BuildContext context) {
    print(data.customerModelList
    );
    return Container(
      width: double.infinity,

      margin: EdgeInsets.only(right: 10, bottom: 5, left: 10, top: 10),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.black26),
        border: TableBorder.all(color: Colors.black),
        rows:List.generate(data.customerModelList.length, (index) {

          return buildDataRow(index, data,context);
        } ,),
        columns: const [

          DataColumn(
            label: Center(child: Text('الاسم')),
          ),
          DataColumn(
            label: Center(child: Text('رقم الهاتف')),
          ),
          DataColumn(
            label: Center(child: Text('العنوان')),
          ),
          DataColumn(
            label: Center(child: Text('المبلغ المديون به')),
          ),
          DataColumn(
            label: Center(child: Text('')),
          ),
        ],
      ),
    );
  }

  DataRow buildDataRow(int index, CustomersCubit data, BuildContext context) {
    var isSmallScreen = MediaQuery.of(context).size.width < 700;

    return DataRow(cells: [
      DataCell(Center(child: Text(data.customerModelList[index].userName??''))),
      DataCell(Center(child: Text(data.customerModelList[index].phone!))),
      DataCell(Center(child: Text(data.customerModelList[index].address!))),
      DataCell(Center(child: Text(data.customerModelList[index].remainingAmount.toString()))),

      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                data.deleteCustomer(
                    data.customerModelList[index].sId.toString());
              },
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                SmartDialog.show(
                    backDismiss: true,
                    onDismiss: () {},
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        width: 600,
                        height: 600,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Directionality(
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
                                        const Icon(
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
                                                  controller: nameController..text=data.customerModelList[index].userName!,
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
                                                  controller: phoneController..text=data.customerModelList[index].phone!,
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
                                                  controller: addressController..text=data.customerModelList[index].address!,
                                                  textInputType: TextInputType.streetAddress,
                                                  isFormField: true,
                                                  hintText: 'ادخل العنوان ',
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
                                                  'المبلغ المديون به',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500, fontSize: 18),
                                                ),
                                                CustomTextField(
                                                  controller: remainingAmountController..text=data.customerModelList[index].remainingAmount.toString()!,
                                                  textInputType: TextInputType.streetAddress,
                                                  isFormField: true,
                                                  hintText: 'ادخل المبلغ ',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                            width: 150,
                                            child: BlocProvider(
                                                create: (context) => CustomersCubit(),
                                                child: BlocConsumer<CustomersCubit,
                                                    CustomersMainState>(
                                                    listener: (BuildContext context, state) async {
                                                      if (state is UpdateCustomersLoadingState) {
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
                                                          remainingAmount: int.parse(remainingAmountController.text));

                                                      if(_formKey.currentState!.validate()){
                                                        CustomersCubit.get(context)
                                                            .updateCustomer(context, customer,data.customerModelList[index].sId!);
                                                      }

                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all(
                                                            accentCanvasColor)),
                                                    child: const Text(
                                                      'تحديث',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  );
                                                })))
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        )
                      );
                    });
              },
              icon: Icon(Icons.update))
        ],
      )),
    ]);
  }
}
