import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class CustomTextField extends StatelessWidget {
  final bool? isFormField ;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool? enable ;
  final bool isValidator;
  final  String? Function(String?)? validatorMessage;
  final Color ?fillColor;
  final TextCapitalization capitalization;
  final bool isBorder;
  CustomTextField(
      {this.controller,
        this.hintText,
        this.textInputType,
        this.maxLine,
        this.focusNode,
        this.enable,
        this.nextNode,
        this.textInputAction,
        this.isPhoneNumber = false,
        this.isValidator=false,
        this.validatorMessage,
        this.capitalization = TextCapitalization.none,
        this.fillColor,
        this.isBorder = false,  this.isFormField,
      });

  @override
  Widget build(context) {
    return TextFormField(
          textAlign: isBorder? TextAlign.center:TextAlign.start,
          controller: controller,
          enabled: enable,
          maxLines: maxLine ?? 1,
          textCapitalization: capitalization,
          maxLength: isPhoneNumber ? 15 : null,
          focusNode: focusNode,
          keyboardType: textInputType ?? TextInputType.text,
          //keyboardType: TextInputType.number,
          initialValue: null,

          //autovalidate: true,
          validator:   (input){
      if(input!.isEmpty){
        return "حقل فارغ";
      }
      return null;

    },

          decoration: InputDecoration(

errorMaxLines: 1,
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            hintText: hintText ?? '',
            filled: true,
            fillColor:Colors.black12,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            isDense: true,

            counterText: '',
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
          ),

    );
  }
}
