class Marka{
  String mName;
  String mInfo;
  String mImageUrl;
  String mensei;
  String ulke;
  String gtin;
  String kategori;
  Marka({this.mName, this.gtin, this.mInfo, this.mImageUrl, this.mensei, this.ulke, this.kategori});
}

List<Marka> mList = [];

List<String> kategoriList =[];

class Ulke{
  String uName;
  String icon;
  Ulke({this.uName, this.icon});
}

List<Ulke> ulkeList = [];