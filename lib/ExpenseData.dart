// import 'package:firebase_database/firebase_database.dart';
// class ExpenseData {
//    String _amount , _date ,_id;
//   ExpenseData(this._id,this._amount ,this._date);
  
//  String get id => _id;
//   String get amount => _amount;

//   String get date => _date;

//   ExpenseData.fromSnapshot(DataSnapshot snapshot) {
//     _id = snapshot.key;
//     _date = snapshot.value['_date'];
//     _amount = snapshot.value['_amount'];
//   }
// }
class ExpenseData {
   String amount , date ,id ,desc;
   
  ExpenseData(this.amount ,this.date,this.id);
  //   final String amount , date;
  //    const ExpenseData(
  //   {
  //   this.amount ,this.date
  //   }
  // );
}