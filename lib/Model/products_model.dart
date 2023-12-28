class ProductsModel {
  String? name;
  String? phone;
  String? address;
  int? prize;
  int? amountPaid;
  int? remainingAmount;
  String? date;
  int? numDresses;
  int? length;
  int? chestLength;
  int? neck;
  int? handLength;
  int? kLength;
  int? mLength;
  String? details;
  String? userId;
  String? createdAt;
  String? image;
  String? sId;
  int? iV;

  ProductsModel(
      {this.name,
        this.phone,
        this.address,
        this.prize,
        this.amountPaid,
        this.remainingAmount,
        this.date,
        this.numDresses,
        this.length,
        this.chestLength,
        this.neck,
        this.handLength,
        this.kLength,
        this.mLength,
        this.details,
        this.userId,
        this.createdAt,
        this.image,
        this.sId,
        this.iV});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    prize = json['prize'];
    amountPaid = json['amount_paid'];
    remainingAmount = json['Remaining_amount'];
    date = json['date'];
    numDresses = json['num_dresses'];
    length = json['length'];
    chestLength = json['chest_length'];
    neck = json['neck'];
    handLength = json['hand_length'];
    kLength = json['k_length'];
    mLength = json['m_length'];
    details = json['details'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    image = json['image'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['prize'] = this.prize;
    data['amount_paid'] = this.amountPaid;
    data['Remaining_amount'] = this.remainingAmount;
    data['date'] = this.date;
    data['num_dresses'] = this.numDresses;
    data['length'] = this.length;
    data['chest_length'] = this.chestLength;
    data['neck'] = this.neck;
    data['hand_length'] = this.handLength;
    data['k_length'] = this.kLength;
    data['m_length'] = this.mLength;
    data['details'] = this.details;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
