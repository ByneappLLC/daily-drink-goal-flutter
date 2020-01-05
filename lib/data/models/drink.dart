class Drink {
  static const String TABLE_NAME = "drinks";

  static const String COLUMN_ID = "drink_id";
  static const String COLUMN_AMOUNT = "amount";
  static const String COLUMN_DATE = "date";

  int id;
  final int amount;
  final int date;

  Drink(this.amount, this.date);
}
