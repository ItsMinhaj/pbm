class  TransModel{
 final String? id;
  final int? amount;
 final String? source;
 final String? type;
 final String? date;


  TransModel({this.id, this.amount, this.source, this.type, this.date});


  Map<String, dynamic> toMap(){
    return {
      "user_id": id,
    "amount": amount,
 "source": source,
 "type": type,
 "date": date,
 };

}
 factory TransModel.fromMap(Map<String,dynamic> map){
    return
      TransModel(id: map["user_id"],
        amount: map["amount"],
        source: map["source"],
        type: map["type"],
        date: map["date"],

      );
    }
 }


