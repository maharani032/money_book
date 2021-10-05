class ItemModel {
  final String id;
  final String namaItem;
  final int stok;
  final int hargaBeli;
  ItemModel(
      {required this.id,
      required this.namaItem,
      required this.stok,
      required this.hargaBeli});
  ItemModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        namaItem = data['namaItem'],
        stok = data['stok'],
        hargaBeli = data['hargaBeli'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaItem': namaItem,
      'stok': stok,
      'hargaBeli': hargaBeli
    };
  }
}
