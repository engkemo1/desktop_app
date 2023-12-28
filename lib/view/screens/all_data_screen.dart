import 'dart:ui' as ui;
import 'package:desktop_app/constants.dart';
import 'package:desktop_app/view/screens/pdf_invoice/file_handeler.dart';
import 'package:desktop_app/view/screens/pdf_invoice/pdf.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/add_state.dart';
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/customTextField.dart';

class AllDataScreen extends StatelessWidget {
  const AllDataScreen({super.key});

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
        create: (context) => ProductCubit()..getData(),
        child: BlocConsumer<ProductCubit, ProductsMainState>(
            listener: (BuildContext context, state) async {
          if (state is GetProductsLoadingState) {
            SmartDialog.showLoading();
            await Future.delayed(Duration(seconds: 2));
            SmartDialog.dismiss();
          }
        }, builder: (BuildContext context, state) {
          var data = ProductCubit.get(context);

          return state is GetProductsLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var date = DateFormat("yyyy/MM/dd").format(
                          DateTime.parse(data.productsModelList[index].date!));
                      var time = DateFormat("HH:mm a").format(DateTime.parse(
                          data.productsModelList[index].createdAt!));

                      return isSmallScreen
                          ? buildCard(
                              index, data, date, time, isSmallScreen, state)
                          : buildCardDesktop(
                              index, data, date, time, isSmallScreen, state);
                    },
                    itemCount: data.productsModelList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5,
                      );
                    },
                  ));
        }),
      ),
    );
  }

  Card buildCard(int index, ProductCubit data, String date, String time,
      bool isSmallScreen, ProductsMainState state) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(right: 10, bottom: 5, left: 10, top: 10),
      child: SizedBox(
        child: ExpansionTile(
          tilePadding: EdgeInsets.only(left: 2, right: 10),
          leading: Text((index+1).toString()),
          title: Text(
            ' الاسم : ${data.productsModelList[index].name} ',
            style: TextStyle(
                fontSize: isSmallScreen ? 12 : 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' القيمة: ${data.productsModelList[index].prize}  ',
                style: TextStyle(fontSize: isSmallScreen ? 12 : 15),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: EdgeInsets.all(20),
          maintainState: true,
          collapsedIconColor: Colors.grey,
          children: [
            Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('التاريخ'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(date, textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('الوقت'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(time, textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('الاسم'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(data.productsModelList[index].name!,
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('رقم الهاتف'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(data.productsModelList[index].phone!,
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('القيمة'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(data.productsModelList[index].prize.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('المبلغ المدفوع'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].amountPaid.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('المبلغ المتبقي'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].remainingAmount
                            .toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('عدد الاثواب'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].numDresses.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('الطول'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(data.productsModelList[index].length.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('وسع الصدر'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].chestLength.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('الرقبة'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(data.productsModelList[index].neck.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('وسع اليد'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].handLength.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'طول الكيك',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].kLength.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('المفصل'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].mLength.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('ملاجظات', textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        data.productsModelList[index].details.toString(),
                        textAlign: TextAlign.center),
                  ),
                ]),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () async {
                        final pdfFile = await PdfInvoiceApi.generate(
                            data.productsModelList[index]);

                        // opening the pdf file
                        FileHandleApi.openFile(pdfFile);
                      },
                      child: Row(
                        children: [
                          Text('طباعة'),
                          !isSmallScreen
                              ? IconButton(
                                  onPressed: () {}, icon: Icon(Icons.print))
                              : SizedBox(),
                        ],
                      )),
                ),
                SizedBox(
                    width: isSmallScreen ? 80 : null,
                    child: ElevatedButton(
                        onPressed: () {
                          data.deleteProduct(
                              data.productsModelList[index].sId.toString());
                        },
                        child: state is DeleteProductsLoadingState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Row(
                                children: [
                                  Text('حذف'),
                                  !isSmallScreen
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.delete))
                                      : SizedBox(),
                                ],
                              ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card buildCardDesktop(int index, ProductCubit data, String date, String time,
      bool isSmallScreen, ProductsMainState state) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(right: 10, bottom: 5, left: 10, top: 10),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.black26),
        border: TableBorder.all(color: Colors.black),
        rows: List.generate(
          data.productsModelList.length,
          (index) => DataRow(cells: [
            DataCell(Center(child: Text((index + 1).toString()))),
            DataCell(Center(child: Text(data.productsModelList[index].name!))),
            DataCell(Center(child: Text(data.productsModelList[index].phone!))),
            DataCell(Center(child: Text("${date}\n ${time}"))),
            DataCell(Center(
                child: Text(data.productsModelList[index].prize.toString()))),
            DataCell(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      data.deleteProduct(
                          data.productsModelList[index].sId.toString());
                    },
                    icon: Icon(Icons.delete)),
                IconButton(
                    onPressed: () async {
                      final pdfFile = await PdfInvoiceApi.generate(
                          data.productsModelList[index]);

                      // opening the pdf file
                      FileHandleApi.openFile(pdfFile);
                    },
                    icon: Icon(Icons.print)),
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
                              child: ListView(
                                children: [
                                  DataTable(
                                    headingRowColor: MaterialStateProperty.all(
                                        Colors.black26),
                                    dataTextStyle: TextStyle(fontSize: 12),
                                    border:
                                        TableBorder.all(color: Colors.black),
                                    rows: List.generate(
                                      data.productsModelList.length,
                                      (index) => DataRow(cells: [
                                        DataCell(Center(
                                          child: Text(data
                                              .productsModelList[index]
                                              .address!),
                                        )),
                                        DataCell(Center(
                                          child: Text(data
                                              .productsModelList[index].phone!),
                                        )),
                                        DataCell(Center(
                                          child: Text(data
                                              .productsModelList[index]
                                              .amountPaid
                                              .toString()),
                                        )),
                                        DataCell(Center(
                                          child: Text(data
                                              .productsModelList[index]
                                              .remainingAmount
                                              .toString()),
                                        )),
                                      ]),
                                    ),
                                    columns: const [
                                      DataColumn(
                                        label: Center(child: Text('العنوان')),
                                      ),
                                      DataColumn(
                                        label:
                                            Center(child: Text('رقم الهاتف')),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: Text('المبلغ المدفوع')),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: Text('المبلغ المتبقي')),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Directionality(
                                    textDirection: ui.TextDirection.rtl,
                                    child: Table(
                                      border:
                                          TableBorder.all(color: Colors.black),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('عدد الاثواب'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                data.productsModelList[index]
                                                    .numDresses
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('الطول'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                data.productsModelList[index]
                                                    .length
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('وسع الصدر'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                data.productsModelList[index]
                                                    .chestLength
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('الرقبة'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                data.productsModelList[index]
                                                    .neck
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('وسع اليد'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                data.productsModelList[index]
                                                    .handLength
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'طول الكيك',
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                data.productsModelList[index]
                                                    .kLength
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('المفصل'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                data.productsModelList[index]
                                                    .mLength
                                                    .toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DataTable(
                                    headingRowColor: MaterialStateProperty.all(
                                        Colors.black26),
                                    border:
                                        TableBorder.all(color: Colors.black),
                                    rows: List.generate(
                                      data.productsModelList.length,
                                      (index) => DataRow(cells: [
                                        DataCell(Text(data
                                            .productsModelList[index]
                                            .details!)),
                                      ]),
                                    ),
                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          '                                                          ملاحظات',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.more_horiz))
              ],
            )),
          ]),
        ),
        columns: const [
          DataColumn(
            label: Center(child: Text('ID')),
          ),
          DataColumn(
            label: Center(child: Text('الاسم')),
          ),
          DataColumn(
            label: Center(child: Text('رقم الهاتف')),
          ),
          DataColumn(
            label: Center(child: Text('التاريخ والوقت')),
          ),
          DataColumn(
            label: Center(child: Text('القيمة')),
          ),
          DataColumn(
            label: Center(child: Text('')),
          ),
        ],
      ),
    );
  }
}
