class Customer {
  String? userName;
  int? remainingAmount;
  String? address;
  String? phone;
  String? sId;
  int? iV;

  Customer(
      {this.userName,
        this.remainingAmount,
        this.address,
        this.phone,
        this.sId,
        this.iV});

  Customer.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    remainingAmount = json['Remaining_amount'];
    address = json['address'];
    phone = json['phone'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['Remaining_amount'] = this.remainingAmount;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
