import 'dart:ui' as ui;
import 'package:desktop_app/view_model/cubit/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import '../../../Model/products_model.dart';
import '../../../constants.dart';
import '../../widgets/customTextField.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController prizeController = TextEditingController();
  TextEditingController amountPaidController = TextEditingController();
  TextEditingController remainingAmountController = TextEditingController();
  TextEditingController numDressesController = TextEditingController();
  TextEditingController chestLengthController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController kLengthController = TextEditingController();
  TextEditingController mLengthController = TextEditingController();
  TextEditingController handLengthController = TextEditingController();
  String _selectedDate = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var isSmallScreen = MediaQuery
        .of(context)
        .size
        .width < 700;

    return Scaffold(
      body: isSmallScreen ? Mobile() : Desktop(),
    );
  }

  _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (selected != null) {
      _selectedDate = DateFormat.yMd().format(selected).toString();
      ProductCubit().changeDate(_selectedDate);
    } else {
      _selectedDate = DateFormat.yMd().format(DateTime.now()).toString();
      ProductCubit().changeDate(_selectedDate);
    }
  }

  Directionality Desktop() {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الاسم',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: nameController,
                                  isFormField: true,
                                  hintText: 'ادخل اسم المشتري',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'رقم الهاتف',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: phoneController,
                                  isPhoneNumber: true,
                                  hintText: 'ادخل رقم الهاتف',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'العنوان',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: addressController,
                                  textInputType: TextInputType.streetAddress,
                                  isFormField: true,
                                  hintText: 'ادخل العنوان ',
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'القيمة',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: prizeController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل القيمة',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'المبلغ المدفوع',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: amountPaidController,
                                  textInputType: TextInputType.number,
                                  isFormField: true,
                                  hintText: ' ادخل المبلغ المدفوع ',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'المبلغ المتبقى',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: remainingAmountController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل المبلغ المتبقى',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'التاريخ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .highlightColor,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 1))
                                    // changes position of shadow
                                  ],
                                ),
                                child: TextField(
                                  controller: _dateController,
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    _selectDate(context);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,

                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    isDense: true,
                                    fillColor: Colors.black12,
                                    enabled: false,
                                    hintText: _selectedDate.toString(),
                                    labelText: _selectedDate.toString(),
                                    labelStyle: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    // iconOrdrop: 'button',
                                    suffix: const Icon(
                                      Icons.date_range,
                                      size: 25,
                                      color: accentCanvasColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Spacer()
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'عدد الاثواب',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: numDressesController,
                                  textInputType: TextInputType.number,
                                  isFormField: true,
                                  hintText: 'ادخل عدد الاثواب',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الطول',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: lengthController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل الطول',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'وسع الصدر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: chestLengthController,
                                  textInputType: TextInputType.number,
                                  isFormField: true,
                                  hintText: ' ادخل وسع الصدر ',
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الرقبة',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: neckController,
                                  textInputType: TextInputType.number,
                                  hintText: 'الرقبة',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'وسع اليد',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: handLengthController,
                                  textInputType: TextInputType.streetAddress,
                                  isFormField: true,
                                  hintText: ' ادخل وسع اليد ',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'طول الكيك ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: kLengthController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل طول الكيك',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'مفصل',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                CustomTextField(
                                  controller: mLengthController,
                                  textInputType: TextInputType.streetAddress,
                                  isFormField: true,
                                  hintText: ' المفصل ',
                                ),
                              ],
                            ),
                          )),
                      const Spacer(),
                      const Spacer()
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: ExpansionTile(
                            // title: Text(''),
                              title: SvgPicture.asset('images/12.svg',
                                  height: 50, semanticsLabel: 'Acme Logo'))),
                      Expanded(
                          child: ExpansionTile(
                              title: Image.asset(
                                'images/crown.png',
                                height: 50,
                              ))),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ملاحظات',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        CustomTextField(
                          controller: detailsController,
                          maxLine: 10,
                          textInputType: TextInputType.text,
                          isFormField: true,
                          hintText: '  ',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {
                                var productsModel = ProductsModel(
                                  name: nameController.text,
                                  date: _selectedDate,
                                  length: int.tryParse(lengthController.text),
                                  address: addressController.text,
                                  amountPaid:
                                  int.tryParse(amountPaidController.text),
                                  chestLength:
                                  int.tryParse(chestLengthController.text),
                                  createdAt: DateTime.now().toString(),
                                  details: detailsController.text,
                                  handLength:
                                  int.tryParse(handLengthController.text),
                                  image: "ds",
                                  kLength: int.tryParse(kLengthController.text),
                                  mLength: int.tryParse(mLengthController.text),
                                  numDresses:
                                  int.tryParse(numDressesController.text),
                                  neck: int.tryParse(neckController.text),
                                  phone: phoneController.text,
                                  prize: int.tryParse(prizeController.text),
                                  remainingAmount: int.tryParse(
                                      remainingAmountController.text),
                                  userId: "1",
                                );


                                if (_formKey.currentState!.validate()) {
                                  print(productsModel);
                                  ProductCubit()
                                      .postProduct(context, productsModel)
                                      .then((value) {
                                    _formKey.currentState!.reset();
                                    nameController.clear();
                                    addressController.clear();
                                    amountPaidController.clear();
                                    chestLengthController.clear();
                                    kLengthController.clear();
                                    phoneController.clear();
                                    detailsController.clear();
                                    mLengthController.clear();
                                    neckController.clear();
                                    remainingAmountController.clear();
                                    prizeController.clear();
                                    numDressesController.clear();
                                    handLengthController.clear();
                                    lengthController.clear();
                                  }
                                  );
                                }

                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      accentCanvasColor)),
                              child: const Text(
                                'اضافة',
                                style: TextStyle(color: Colors.white),
                              ))),
                      SizedBox(
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      accentCanvasColor)),
                              child: Text('طباعة',
                                  style: TextStyle(color: Colors.white)))),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Directionality Mobile() {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'الاسم',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        CustomTextField(
                          controller: nameController,
                          textInputType: TextInputType.name,
                          isFormField: true,
                          hintText: 'ادخل اسم المشتري',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'رقم الهاتف',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        CustomTextField(
                          controller: phoneController,
                          textInputType: TextInputType.number,
                          hintText: 'ادخل رقم الهاتف',
                          isFormField: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'العنوان',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'القيمة',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        CustomTextField(
                          controller: prizeController,
                          textInputType: TextInputType.number,
                          hintText: 'ادخل القيمة',
                          isFormField: true,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'المبلغ المدفوع',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: amountPaidController,
                                  textInputType: TextInputType.number,
                                  isFormField: true,
                                  hintText: ' ادخل المبلغ المدفوع ',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'المبلغ المتبقى',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: remainingAmountController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل المبلغ المتبقى',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'التاريخ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .highlightColor,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 1))
                              // changes position of shadow
                            ],
                          ),
                          child: TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              border: InputBorder.none,

                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                              isDense: true,
                              fillColor: Colors.black12,
                              enabled: false,
                              hintText: _selectedDate.toString(),
                              labelText: _selectedDate.toString(),
                              labelStyle: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              // iconOrdrop: 'button',
                              suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: accentCanvasColor,
                                  ),
                                  onPressed: () {
                                    _selectDate(context);
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'عدد الاثواب',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: numDressesController,
                                  isFormField: true,
                                  hintText: 'ادخل عدد الاثواب',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الطول',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: lengthController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل الطول',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'وسع الصدر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: chestLengthController,
                                  textInputType: TextInputType.streetAddress,
                                  isFormField: true,
                                  hintText: ' ادخل وسع الصدر ',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الرقبة',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: neckController,
                                  textInputType: TextInputType.number,
                                  hintText: 'الرقبة',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'وسع اليد',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: handLengthController,
                                  textInputType: TextInputType.number,
                                  isFormField: true,
                                  hintText: ' ادخل وسع اليد ',
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'طول الكيك ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(
                                  controller: kLengthController,
                                  textInputType: TextInputType.number,
                                  hintText: 'ادخل طول الكيك',
                                  isFormField: true,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'مفصل',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                CustomTextField(

                                  controller: mLengthController,
                                  textInputType: TextInputType.streetAddress,
                                  isFormField: true,
                                  hintText: ' المفصل ',
                                ),
                              ],
                            ),
                          )),
                      const Spacer()
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: ExpansionTile(
                            title: Text(''),
                            leading: Image.asset(
                              'images/1.jpeg',
                              height: 80,
                            ),
                          )),
                      Expanded(
                          child: ExpansionTile(
                              title: Image.asset(
                                'images/crown.png',
                                height: 50,
                              ))),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ملاحظات',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        CustomTextField(
                          controller: detailsController,

                          maxLine: 4,
                          textInputType: TextInputType.text,
                          isFormField: true,
                          hintText: '  ',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          child: ElevatedButton(
                              onPressed: () {
                                var productsModel = ProductsModel(
                                  name: nameController.text,
                                  date: _selectedDate,
                                  length: int.tryParse(lengthController.text),
                                  address: addressController.text,
                                  amountPaid:
                                  int.tryParse(amountPaidController.text),
                                  chestLength:
                                  int.tryParse(chestLengthController.text),
                                  createdAt: DateTime.now().toString(),
                                  details: detailsController.text,
                                  handLength:
                                  int.tryParse(handLengthController.text),
                                  image: "ds",
                                  kLength: int.tryParse(kLengthController.text),
                                  mLength: int.tryParse(mLengthController.text),
                                  numDresses:
                                  int.tryParse(numDressesController.text),
                                  neck: int.tryParse(neckController.text),
                                  phone: phoneController.text,
                                  prize: int.tryParse(prizeController.text),
                                  remainingAmount: int.tryParse(
                                      remainingAmountController.text),
                                  userId: "1",
                                );


                                  if (_formKey.currentState!.validate()) {
                                    print(productsModel);
                                    ProductCubit()
                                        .postProduct(context, productsModel)
                                        .then((value) {
                                      _formKey.currentState!.reset();
                                      nameController.clear();
                                      addressController.clear();
                                      amountPaidController.clear();
                                      chestLengthController.clear();
                                      kLengthController.clear();
                                      phoneController.clear();
                                      detailsController.clear();
                                      mLengthController.clear();
                                      neckController.clear();
                                      remainingAmountController.clear();
                                      prizeController.clear();
                                      numDressesController.clear();
                                      handLengthController.clear();
                                      lengthController.clear();
                                    }
                                    );
                                  }

                              },
                              child: Text(
                                'اضافة',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      accentCanvasColor)))),
                      SizedBox(
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text('طباعة',
                                  style: TextStyle(color: Colors.white)),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      accentCanvasColor)))),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
