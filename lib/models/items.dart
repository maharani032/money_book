class ItemModel {
  String userId;
  String namaItem;
  String stok;
  String hargaBeli;
  ItemModel(
      {
      required this.namaItem,
      required this.stok,
      required this.hargaBeli,
      required this.userId});
  // ItemModel.fromData(Map<String, dynamic> data)
  //     : userId=data['userId'],
  //       namaItem = data['namaItem'],
  //       stok = data['stok'],
  //       hargaBeli = data['hargaBeli'];
  Map<String, dynamic> toMap() {
    return {
      'userId':userId,
      'namaItem': namaItem,
      'stok': stok,
      'hargaBeli': hargaBeli
    };
  }
}
