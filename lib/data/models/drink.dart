class Drink {
  static const String TABLE_NAME = "drinks";

  static const String COLUMN_ID = "drink_id";
  static const String COLUMN_AMOUNT = "amount";
  static const String COLUMN_DATE = "date";

  int id;
  final int amount;
  final int date;

  Drink(this.amount, this.date);

  Drink.fromMap(Map<String, dynamic> map)
      : id = map[COLUMN_ID],
        amount = map[COLUMN_AMOUNT],
        date = map[COLUMN_DATE];

  Map<String, dynamic> toMap() {
    final map = {
      COLUMN_AMOUNT: amount,
      COLUMN_DATE: date,
    };
    if (id != null) {
      map.putIfAbsent(COLUMN_ID, () => id);
    }
    return map;
  }
}
