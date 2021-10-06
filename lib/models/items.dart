class ItemModel {
  String userId;
  String id;
  String namaItem;
  int stok;
  int hargaBeli;
  ItemModel(
      {
      required this.id,
      required this.namaItem,
      required this.stok,
      required this.hargaBeli,
      required this.userId});
  ItemModel.fromData(Map<String, dynamic> data)
      :id=data['id'], 
      userId=data['userId'],
        namaItem = data['namaItem'],
        stok = data['stok'],
        hargaBeli = data['hargaBeli'];
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'userId': userId,
      'namaItem': namaItem,
      'stok': stok,
      'hargaBeli': hargaBeli
    };
  }
}
