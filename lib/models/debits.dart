class DebitModel{
  String id;
  String userId;
  String namaDebit;
  int jumlah;
  DateTime date;
  DebitModel({
    required this.id,
    required this.userId,
    required this.namaDebit,
    required this.jumlah,
    required this.date,
  });
  DebitModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        namaDebit = data['namaDebit'],
        jumlah = data['jumlah'],
        date = data['date'];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'namaDebit': namaDebit,
      'jumlah': jumlah,
      'date': date
    };
  }
}