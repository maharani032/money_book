class CreditModel {
  String id;
  String userId;
  String namaCredit;
  int jumlah;
  DateTime date;
  CreditModel({
    required this.id,
    required this.userId,
    required this.namaCredit,
    required this.jumlah,
    required this.date,
  });
  CreditModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        namaCredit = data['namaCredit'],
        jumlah = data['jumlah'],
        date = data['date'];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'namaCredit': namaCredit,
      'jumlah': jumlah,
      'date': date
    };
  }
}
