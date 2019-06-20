import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:html/parser.dart' show parse;

import 'package:flutter_html_view/flutter_html_text.dart';
import 'package:muhtesip/colors.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:muhtesip/marka.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:share/share.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'package:flushbar/flushbar.dart';

import 'package:connectivity/connectivity.dart';

import 'package:firebase_admob/firebase_admob.dart';

void main() => runApp(new MyApp());

bool darkTheme = false;

final app_id = "ca-app-pub-8974872775502806~5047996836";
final banner_id = "ca-app-pub-8974872775502806/7805736706";
final inter_id = "ca-app-pub-8974872775502806/7806145823";
int reklamSayac = 0;

MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(// or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = new BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: banner_id,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = new InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: inter_id,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
          title: "Muhtesip",
          debugShowCheckedModeBanner: false,
          theme: snapshot.data ? ThemeData.dark() : anaTema,
          home: MyHomePage(snapshot.data)),
    );
  }
}

/*MaterialApp(
      title: 'BiMarka',
      debugShowCheckedModeBanner: false,
      theme: darkTheme ? ThemeData.dark() : anaTema,
      home: new MyHomePage(),
    );*/
 class Bloc {
    final _themeController = StreamController<bool>();
    get changeTheme => _themeController.sink.add;
    get darkThemeEnabled => _themeController.stream;
  }

  final bloc = Bloc();


// TODO 
/*
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
*/
class MyHomePage extends StatefulWidget {
  @override
  bool darkThemeEnabled;
  MyHomePage(this.darkThemeEnabled);
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  String barcode = "";
  
  String ulkeKod(String tamUlkeAd){
    if(tamUlkeAd == "Türkiye"){
      return "tr";
    }else if(tamUlkeAd == "Tayvan"){
      return "tw";
    }else if(tamUlkeAd == "Amerika"){
      return "us";
    }else if(tamUlkeAd == "Avusturya"){
      return "at";
    }else if(tamUlkeAd == "Almanya"){
      return "de";
    }else if(tamUlkeAd == "Azerbaycan"){
      return "az";
    }else if(tamUlkeAd == "Bulgaristan"){
      return "bg";
    }else if(tamUlkeAd == "İngiltere"){
      return "gb";
    }else if(tamUlkeAd == "İrlanda"){
      return "ie";
    }else if(tamUlkeAd == "İsveç"){
      return "se";
    }else if(tamUlkeAd == "İzlanda"){
      return "is";
    }else if(tamUlkeAd == "Libya"){
      return "ly";
    }else if(tamUlkeAd == "Meksika"){
      return "mx";
    }else if(tamUlkeAd == "Mısır"){
      return "eg";
    }else if(tamUlkeAd == "Pakistan"){
      return "pk";
    }else if(tamUlkeAd == "Portekiz"){
      return "pt";
    }else if(tamUlkeAd == "Romanya"){
      return "ro";
    }else if(tamUlkeAd == "Suudi Arabistan"){
      return "sa";
    }else if(tamUlkeAd == "Tunus"){
      return "tn";
    }else if(tamUlkeAd == "Uganda"){
      return "ug";
    }else if(tamUlkeAd == "Venezuela"){
      return "ve";
    }else if(tamUlkeAd == "Arjantin"){
      return "ar";
    }else if(tamUlkeAd == "Yunanistan"){
      return "gr";
    }else if(tamUlkeAd == "Brezilya"){
      return "br";
    }else if(tamUlkeAd == "Çin"){
      return "cn";
    }else if(tamUlkeAd == "Fas"){
      return "ma";
    }else if(tamUlkeAd == "Fransa"){
      return "fr";
    }else if(tamUlkeAd == "Gine"){
      return "gn";
    }else if(tamUlkeAd == "Güney Kore"){
      return "kr";
    }else if(tamUlkeAd == "Hollanda"){
      return "nl";
    }else if(tamUlkeAd == "Irak"){
      return "iq";
    }else if(tamUlkeAd == "İspanya"){
      return "es";
    }else if(tamUlkeAd == "İsviçre"){
      return "ch";
    }else if(tamUlkeAd == "Kazakistan"){
      return "kz";
    }else if(tamUlkeAd == "Kuzey Kore"){
      return "kp";
    }else if(tamUlkeAd == "Küba"){
      return "cu";
    }else if(tamUlkeAd == "Letonya"){
      return "lv";
    }else if(tamUlkeAd == "Norveç"){
      return "no";
    }else if(tamUlkeAd == "Peru"){
      return "pe";
    }else if(tamUlkeAd == "Ukrayna"){
      return "ua";
    }else if(tamUlkeAd == "Uruguay"){
      return "uy";
    }else if(tamUlkeAd == "Vietnam"){
      return "vn";
    }else if(tamUlkeAd == "Arnavutluk"){
      return "al";
    }else if(tamUlkeAd == "Avustralya"){
      return "au";
    }else if(tamUlkeAd == "Bangladeş"){
      return "bd";
    }else if(tamUlkeAd == "Belçika"){
      return "be";
    }else if(tamUlkeAd == "Bosna Hersek"){
      return "ba";
    }else if(tamUlkeAd == "Cezayir"){
      return "dz";
    }else if(tamUlkeAd == "Danimarka"){
      return "dk";
    }else if(tamUlkeAd == "Ermenistan"){
      return "am";
    }else if(tamUlkeAd == "Gürcistan"){
      return "ge";
    }else if(tamUlkeAd == "Hindistan"){
      return "in";
    }else if(tamUlkeAd == "İran"){
      return "ir";
    }else if(tamUlkeAd == "İsrail"){
      return "il";
    }else if(tamUlkeAd == "İtalya"){
      return "it";
    }else if(tamUlkeAd == "Japonya"){
      return "jp";
    }else if(tamUlkeAd == "Kanada"){
      return "ca";
    }else if(tamUlkeAd == "Katar"){
      return "qa";
    }else if(tamUlkeAd == "Kenya"){
      return "ke";
    }else if(tamUlkeAd == "Kolombiya"){
      return "co";
    }else if(tamUlkeAd == "Liberya"){
      return "lr";
    }else if(tamUlkeAd == "Litvanya"){
      return "lt";
    }else if(tamUlkeAd == "Macaristan"){
      return "hu";
    }else if(tamUlkeAd == "Makedonya"){
      return "mk";
    }else if(tamUlkeAd == "Malezya"){
      return "my";
    }else if(tamUlkeAd == "Moldovya"){
      return "md";
    }else if(tamUlkeAd == "Nijer"){
      return "ne";
    }else if(tamUlkeAd == "Özbekistan"){
      return "uz";
    }else if(tamUlkeAd == "Şili"){
      return "cl";
    }else if(tamUlkeAd == "Somali"){
      return "so";
    }else if(tamUlkeAd == "Suriye"){
      return "sy";
    }else if(tamUlkeAd == "Tacikistan"){
      return "tj";
    }else if(tamUlkeAd == "Tayland"){
      return "th";
    }else if(tamUlkeAd == "Türkmenistan"){
      return "tm";
    }else if(tamUlkeAd == "Yeni Zellanda"){
      return "nz";
    }
  }

  TabController tabController;
  String jsonUrl = "http://crazyturkish.com/wp-json/wp/v2/posts?per_page=100&_embed";
  List veri;
  Future<Null> getData() async{
    http.Response data = await http.get(
        Uri.encodeFull(jsonUrl),
        headers: {
          "Accept": "application/json"
        }
    );
    this.setState((){
      veri = json.decode(data.body);
      for(int i = 0; i< veri.length; i++){
        String name = veri[i]['title']['rendered'].toString();
        String content = veri[i]['content']['rendered'].toString();
        String imageUrl = veri[i]["_embedded"]["wp:featuredmedia"][0]["source_url"].toString();
        String tag = veri[i]["_embedded"]['wp:term'][1][0]['name'].toString();
        String category = veri[i]["_embedded"]['wp:term'][0][0]['name'].toString();
      String fullYazi = content;
      String gtin;
      if(!kategoriList.contains(category)){
        kategoriList.add(category);
      }
      bool mevcut = false;

      for(int item = 0; item < ulkeList.length; item++){
        if(ulkeList[item].uName == tag){
          mevcut = true;
        }
      }
      if(!mevcut){
        String newLink = "http://crazyturkish.com/wp-content/uploads/2018/09/";
        String ulkeKodu = ulkeKod(tag);
        newLink = newLink + ulkeKodu + ".png";
        Ulke newUlk = Ulke(uName: tag, icon: newLink);
        ulkeList.add(newUlk);
      }

      HtmlParser parser = new HtmlParser();
      List elementList = parser.parse(fullYazi);

      for(int i = 0; i < elementList.length; i++){
        String tag = elementList[i]['tag'].toString();
          if (tag == 'strong') {
            gtin = elementList[i]['text'].toString();
          }
      }
      Marka yeni;
        if(gtin == null){
          yeni = Marka(mName: name, mInfo: content, mensei: tag, ulke: tag, mImageUrl: imageUrl, kategori: category);
        }else{
          yeni = Marka(mName: name, mInfo: content, mensei: tag, ulke: tag, mImageUrl: imageUrl, kategori: category, gtin: gtin);
        }
        bool isContain = false;
        for(int i = 0; i < mList.length; i++){
          if(yeni.mName == mList[i].mName){
              isContain = true;
          }
        }
        if(!isContain){
          mList.add(yeni);
        }
      }
    });
  }

    Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      String markaKod = barcode.substring(0, 7);
      Marka theMarka;
      for(int i = 0; i < mList.length; i++){
        if(mList[i].gtin == markaKod){
         theMarka = mList[i];
        };
      }
      setState(() {
        if(theMarka == null){
          Flushbar(message: "Marka Bulunamadı", backgroundColor: Colors.red, duration: Duration(seconds: 2), flushbarPosition: FlushbarPosition.TOP,).show(context);
        }else{
          navigatePage(context, theMarka);
        }
        this.barcode = barcode;

      } );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Kameraya Erişim İzini Alınamadı!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
}

  void ekle(){
    Marka ey = new Marka(mName: "ASUS", mImageUrl: "https://pbs.twimg.com/profile_images/378800000322776927/f1ae67d3bd3904d0ab83b79e43052592_400x400.png", mInfo: "af", mensei: "Yerli");

    setState(() {
        });
  }
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState(){
    super.initState();
    FirebaseAdMob.instance.initialize(appId: app_id);
    if(reklamSayac == 3 ){

    }
     connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {
        });
      }else{
        Flushbar(backgroundColor: Colors.red,title: "Bağlantı Yok", messageText: Text("Uygulamanın Çalışması İçin İnternet Bağlantısı Gerekmektedir.", style: TextStyle(color: Colors.white),), showProgressIndicator: true,).show(context);
      }
    });
    getData();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
  subscription.cancel();
  myBanner?.dispose();
    tabController.dispose();
    super.dispose();
  }

  urlAc(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    final queryData = MediaQuery.of(context);
    final double screenWidth = queryData.size.width;
    final double screenHeight = queryData.size.height;
    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: screenHeight/8,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
      if(reklamSayac == 3){
        myInterstitial
          ..load()
          ..show(
            anchorType: AnchorType.bottom,
            anchorOffset: 0.0,
        );
        reklamSayac = 0;
      }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton(
            backgroundColor: iconColors,
            foregroundColor: Colors.white,
            child: Icon(Icons.camera_alt),
            onPressed: scan,
          ),
      drawer: Drawer(
        child: Scaffold(
          
          body: Column(
            children: <Widget>[
              Container(
                height: screenHeight/3,
                child: UserAccountsDrawerHeader(
                   decoration: BoxDecoration(
                     color: Colors.teal,
                    image: new DecorationImage(
                      
                      image: AssetImage('lib/assets/finalLogo.png'),
                    ),
                  ),
                  accountEmail: Text("muhtesipapp@gmail.com"),
                  accountName: Text("Muhtesip"),),
              ),
              Container(
                height: screenHeight * 2 / 3,
                //margin: EdgeInsets.only(top: 50.0, left: screenWidth/30, right: screenWidth/30),
                child: ListView(
                  children: <Widget>[
                    Card(
                      child: ExpansionTile(
                        leading: Icon(Icons.place),
                        title: Text("Ülkeler"),
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: ulkeList.length,
                            itemBuilder: (context, i){
                              return Card(child: ListTile(leading: Image.network(ulkeList[i].icon, fit: BoxFit.fitHeight, height: screenHeight/20,), title: Text(ulkeList[i].uName, ),
                              onTap: () =>  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new UlkeOzel(ulke: ulkeList[i].uName,)))
                              ));
                            },
                          )
                      ],),
                    ),
                    Card(
                      child: ExpansionTile(
                        leading: Icon(Icons.list),
                        title: Text("Kategoriler"),
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: kategoriList.length,
                            itemBuilder: (context, i){
                              return Card(child: ListTile(title: Text(kategoriList[i]),
                                  onTap: () =>  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new KategoriOzel(index: i)))
                              ));
                            },
                          )
                      ],),
                    ),
                    Card(
                      child: ExpansionTile(
                        leading: Icon(Icons.supervisor_account),
                        title: Text("İletişim"),
                        children: <Widget>[
                          Card(
                              child: ListTile(
                                leading: Icon(Icons.report),
                                title: Text("Sorun Bildir"),
                                onTap: () =>  urlAc("https://goo.gl/forms/TLEwO9RMYyLicr8F3"),
                              )),
                          Card(
                              child: ListTile(
                                leading: Icon(Icons.copyright),
                                title: Text("Marka Öner"),
                                onTap: () =>  urlAc("https://goo.gl/forms/TLEwO9RMYyLicr8F3"),
                              )),
                          Card(
                              child: ListTile(
                                leading: Icon(Icons.contact_mail),
                                title: Text("Bize Ulaşın"),
                                onTap: () =>  urlAc("mailto:muhtesipapp@gmail.com"),
                              )),

                        ],
                      )
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Karanlık Tema"),
                        leading: Icon(Icons.color_lens),
                        trailing: Switch(value: widget.darkThemeEnabled, onChanged: bloc.changeTheme

                        )
                      ),
                    )

                  ],
                )
              ),
            ]
          ),
        )
      ),
      appBar: AppBar(
        title: Image.asset("lib/assets/finalImage.png", color: Colors.white, width: screenWidth/3,),
        //title: Text("Muhtesip", style: TextStyle(fontSize: 26.0, color: Colors.white),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => SearchPage()));},),
        ],
      ),
      body: TabBarView(

          controller: tabController,
          children: <Widget>[
                Yerli(),
                Yabanci()

              ],
      ),
        bottomNavigationBar: Material(
          
          color: bottomNavigation,
          child: TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text("Yerli", style: TextStyle(color: Colors.white),),
              ),
              Tab(
               child: Text("Yabancı", style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
    );
  }
}

  void navigatePage(BuildContext context, Marka myMarka){
    reklamSayac++;
   Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new ReadPage(myMarka)));
  }

  List<String> infoBuild(Marka marka){
  List<String> markaInfo = ['0', '0', '0', '0'];

  String fullYazi = marka.mInfo.toString();

    HtmlParser parser = new HtmlParser();
    List elementList = parser.parse(fullYazi);

    for(int i = 0; i < elementList.length; i++){

      String tag = elementList[i]['tag'].toString();
      if (tag == 'h4') {
        markaInfo[0] = elementList[i]['text'].toString();
      }else if (tag == 'h1') {
        markaInfo[1] = elementList[i]['text'].toString();
      }else if (tag == 'h2') {
        markaInfo[2] = elementList[i]['text'].toString();
      }else if (tag == 'h3') {
        markaInfo[3] = elementList[i]['text'].toString();
      }
    }
  return markaInfo;
}


class StokVeri {
  String name;
  double yuzdelik;
  Color color;
  StokVeri({this.name, this.yuzdelik, this.color});
}

class ReadPage extends StatefulWidget {
  final Marka myMarka;

  ReadPage(this.myMarka);


  @override
  ReadPageState createState() {
    return new ReadPageState();
  }
}

class ReadPageState extends State<ReadPage> with TickerProviderStateMixin{

TabController tabKontrol;

  @override
  void initState(){
    super.initState();

    tabKontrol = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose(){
    tabKontrol.dispose();
    super.dispose();
  }

  _navigation(String ulke){
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new UlkeOzel(ulke: ulke)));
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final double screenWidth = queryData.size.width;
    final double screenHeight = queryData.size.height;
    int a = 0;
    a = ulkeList.indexWhere((Ulke i) => widget.myMarka.ulke == i.uName);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myMarka.mName),
        actions: <Widget>[
          InkWell(
            onTap: () =>  _navigation(ulkeList[a].uName),
            child: Container(
              width: screenWidth / 6,
              margin: EdgeInsets.only(right: 8.0),
              child: Image.network(ulkeList[a].icon)
            ),
          )
        ],
      ),
      body:  TabBarView(
          controller: tabKontrol,
          children: <Widget>[
                OrtaklikYapisi(myMarka: widget.myMarka),
                Hakkinda(myMarka: widget.myMarka),
                Iletisim(myMarka: widget.myMarka)

              ],
      ),
       bottomNavigationBar: Material(
          color: bottomNavigation,
          child: TabBar(
            controller: tabKontrol,
            tabs: <Widget>[
              Tab(
                child: Text("Ortaklık Yapısı", style: TextStyle(color: Colors.white),),
              ),
              Tab(
                child: Text("Hakkında", style: TextStyle(color: Colors.white),),
              ),
              Tab(
                child: Text("İletişim", style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
    );
  }
}

class OrtaklikYapisi extends StatelessWidget {
  Marka myMarka;

  OrtaklikYapisi({this.myMarka});

  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<
      AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final double screenWidth = queryData.size.width;
    final double screenHeight = queryData.size.height;

    List<String> infoList = infoBuild(myMarka);
    String resmiAd = infoList[0]; //0 = Resmi isim
    String kTarih = infoList[1]; //1 = Kuruluş Tarihi
    String kurucular = infoList[2]; //2 = Kurucular
    String hisseBilg = infoList[3]; //3 = Hisse Bilgileri
    List<String> sirketHisse = hisseBilg.split(';');

    List<List<String>> hisseAyrinti = [];

    for (int i = 0; i < sirketHisse.length - 1; i++) {
      hisseAyrinti.add(sirketHisse[i].split(':'));
    }

    for (int i = 0; i < sirketHisse.length - 1; i++) {
      hisseAyrinti[i][1] = hisseAyrinti[i][1].replaceAll('%', '');
    }

    List<Color> colorList = [ Colors.lightGreen, Colors.pink, Colors.orangeAccent, Colors.purple, Colors.teal, Colors.black];
    List<StokVeri> stokList = [];

    int max = 3;
    bool incomp = false;
    double toplam = 0.0;
    sirketHisse.length > 4 ? max = 4 : max = sirketHisse.length - 1;

    for (int i = 0; i < max; i++) {
      toplam += double.parse(hisseAyrinti[i][1]);
      stokList.add(StokVeri(name: hisseAyrinti[i][0],
          yuzdelik: double.parse(hisseAyrinti[i][1]),
          color: colorList[i]));
    }
    print(toplam.toString());
    if(toplam != 100.0){
      print("Eklenmekte");
      stokList.add(StokVeri(name: "Diğer", yuzdelik: 100.0 - toplam, color: Colors.blue));
      max++;
      incomp = true;
    }

    List<CircularSegmentEntry> chartList = [];
    List<Stock_Holder> stokHolderList = [];

    for (int i = 0; i < max ; i++) {
      chartList.add(CircularSegmentEntry(
          stokList[i].yuzdelik, stokList[i].color, rankKey: 'Q$i')
      );
      if(incomp){
        if(i < max - 1){
          stokHolderList.add(Stock_Holder(name: hisseAyrinti[i][0],
              yuzdelik: double.parse(hisseAyrinti[i][1]),
              color: colorList[i])
          );
        }else{
          stokHolderList.add(Stock_Holder(
              name: "Diğer",
              yuzdelik: 100.0 - toplam,
              color: Colors.blue));
        }
      }else{
        stokHolderList.add(Stock_Holder(name: hisseAyrinti[i][0],
            yuzdelik: double.parse(hisseAyrinti[i][1]),
            color: colorList[i])
        );
      }
    }


    List<DataColumn> dataColumnList = [
      DataColumn(
          label: Text("İsim")
      ),
      DataColumn(
          label: Text("Yüzdelik")
      ),
      DataColumn(
          label: Text("Sermaye")
      ),
    ];

    void _showDialog(String isim, String yuzdelik, String miktar) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(isim),
            content: Text("Sahip Olduğu $yuzdelik hisse $miktar miktarına denk gelmektedir"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Kapat"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    List<DataRow> dataRowList = [];

    for (int ke = 0; ke < sirketHisse.length; ke++) {
      String isim;
      String yuzdelik;
      String miktar;

      List line = sirketHisse[ke].split(':');
      isim = line[0].toString();
      yuzdelik = line[1].toString();
      miktar = line[2].toString();

      dataRowList.add(
          DataRow(
              cells: <DataCell>[
                DataCell(Container(child: Text(isim, overflow: TextOverflow.ellipsis, maxLines: 3,)), onTap: () => _showDialog(isim, yuzdelik, miktar) ),
                DataCell(Text(yuzdelik), onTap: () => _showDialog(isim, yuzdelik, miktar) ),
                DataCell(Text(miktar), onTap: () => _showDialog(isim, yuzdelik, miktar) ),

              ]
          )
      );
    }

      return Container(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 35, vertical: screenHeight / 100),
          child: ListView(
            children: <Widget>[
              MarkaTemel(myMarka: myMarka),
              Padding(padding: EdgeInsets.only(top: screenHeight / 1000)),
              Column(

                children: <Widget>[
                  SafeArea(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: stokHolderList
                  )),
                  SafeArea(
                    child: AnimatedCircularChart(
                      key: _chartKey,
                      size: Size(screenWidth/2 , screenWidth/2 ),
                      initialChartData: <CircularStackEntry>[
                        CircularStackEntry(
                          chartList,
                          rankKey: 'Quarterly Profits',
                        ),
                      ],
                      percentageValues: true,
                      duration: Duration(seconds: 1),
                      chartType: CircularChartType.Radial,
                      holeLabel: myMarka.mName.toString(),
                      labelStyle: new TextStyle(
                        color: niceColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),

                ],
              ),
              Container(
                child: DataTable(
                    columns: dataColumnList, rows: dataRowList
                ),
              ),

            ],
          ),
        ),
      );
    }
  }

class Hakkinda extends StatelessWidget {
  final Marka myMarka;
  Hakkinda({this.myMarka});

  @override
  Widget build(BuildContext context) {
    String fullYazi = myMarka.mInfo.toString();
    String italikParca = "";
    String hakkimizda = "Bilgi verilmemiştir.";
    String baslik = "Marka";
    HtmlParser parser = new HtmlParser();
    List elementList = parser.parse(fullYazi);

    for(int i = 0; i < elementList.length; i++){

      String tag = elementList[i]['tag'].toString();
      List<String> ey = [];
      if (tag == 'em') {
        italikParca = elementList[i]['text'].toString();
        ey = italikParca.split('½}');
        hakkimizda = ey[0];
        ey = hakkimizda.split('}*');
        baslik = ey[0];
        hakkimizda = ey[1].replaceAll('\\n', '\n');
      }
    }
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ListView(
            children: <Widget>[
              MarkaTemel(myMarka: myMarka),
              Container(
                  color: primaryColor,
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0, right: 4.0),
                  child: Text(baslik, style: TextStyle(fontSize: 22.0, fontFamily: "Gotham", color: Colors.white),textAlign: TextAlign.center,)),
              Container(
                margin: EdgeInsets.all(12.0),
                child: Text(hakkimizda, style: TextStyle(fontSize: 16.0, fontFamily: "Segoe UI"),),
              )
              ]
              )
    );
  }
}

class Iletisim extends StatelessWidget {
  Marka myMarka;
  Iletisim({this.myMarka});
  @override



  Widget build(BuildContext context) {
    launchAdres (String url) async{
      if (await canLaunch(url)) {
      await launch(url);
      } else {
      throw 'Could not launch $url';
      }
    }
    String fullYazi = myMarka.mInfo.toString();
    String italikParca = "";
    String iletisim = "Bilgi verilmemiştir.";
    String telefonNo = "";
    String adres = "";
    String mail = "";
    String website = myMarka.mName;
    HtmlParser parser = new HtmlParser();
    List elementList = parser.parse(fullYazi);

    for(int i = 0; i < elementList.length; i++){

      String tag = elementList[i]['tag'].toString();
      List<String> ey = [];
      if (tag == 'em') {
        italikParca = elementList[i]['text'].toString();
        ey = italikParca.split('½}');
        iletisim = ey[1];
        ey = iletisim.split('|');
        adres = ey[0];
        telefonNo = ey[1];
        mail = ey[2];
      }else if(tag == 'h5'){
        website = elementList[i]['text'].toString();
      }
    }
    String adresLink = "https://www.google.com/maps/place/";
    adresLink = adresLink + adres.replaceAll(' ', '+');
    String sonMail = "mailto:";
    sonMail = sonMail + mail;
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ListView(
            children: <Widget>[
              MarkaTemel(myMarka: myMarka),

              Divider(height: 16.0,color: primaryColor),
              Card(
                  child:  ListTile(
                    leading: Text("Adres"),
                    title: Center(child: Text(adres)),
                    trailing: Icon(Icons.location_on, color: iconColors,),
                    onTap:() => launchAdres(adresLink),
                  ),
                ),
              Padding(padding: EdgeInsets.only(top: 24.0)),
              Card(child: ListTile(
                leading: Text("Telefon Numarası"),
                title: Text(telefonNo),
                trailing: Icon(Icons.phone, color: iconColors),
                onTap: () => launch('tel://${telefonNo}'),
              ),),
              Padding(padding: EdgeInsets.only(top: 24.0)),
              Card(child: ListTile(
                leading: Text("Mail Adresi"),
                title: Text(mail),
                trailing: Icon(Icons.mail, color: iconColors),
                onTap: () => launch(sonMail),
              ),),
              Padding(padding: EdgeInsets.only(top: 24.0)),
              Card(child: ListTile(
                leading: Text("İnternet Sitesi"),
                title: Text(website),
                trailing: Icon(Icons.public, color: iconColors),
                onTap: () => _launchURL(myMarka),
              ),),

      ],)
    );
  }
}

class MarkaTemel extends StatelessWidget {
  const MarkaTemel({
    Key key,
    @required this.myMarka,
  }) : super(key: key);

  final Marka myMarka;

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final double screenWidth = queryData.size.width;
    final double screenHeight = queryData.size.height;

    List<String> infoList = infoBuild(myMarka);

    String resmiAd = infoList[0];//0 = Resmi isim
    String kTarih = infoList[1];//1 = Kuruluş Tarihi
    String kurucular = infoList[2];//2 = Kurucular
    String hisseBilg = infoList[3];//3 = Hisse Bilgileri
    List<String> sirketHisse = hisseBilg.split(';');
    List<String> hisseAyrimti = sirketHisse[0].split(':');
    String chSahip = hisseAyrimti[0].toString();
    //kurucular = kurucular.replaceAll(',', '\n');
    TextStyle mainStyle = TextStyle(
        color: Colors.white,
        fontSize: 12.0

    );
    TextStyle baslikStyle = TextStyle(
      color: Colors.white,
      fontSize: 18.0
    );
    double singleHeight = screenHeight/14;
    return Container(
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: screenHeight/100),
              height: screenHeight/4,
              width: screenWidth *1.8/3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Container(
                    height: singleHeight,
                    child: ListTile(
                      title: Text("Kuruluş Tarihi", style: baslikStyle),
                      subtitle: Text(kTarih, style: mainStyle,),
                    ),
                  ),
                  Container(
                    height: singleHeight,
                    child: ListTile(
                      title: Text("Kurucu", style: baslikStyle),
                      subtitle: Text(kurucular, style: mainStyle,),
                    ),
                  ),
                  Container(
                    height: singleHeight,
                    child: ListTile(
                      title: Text("Çoğunluk Hisse Sahibi", style: baslikStyle),
                      subtitle: Text(chSahip, style: mainStyle,),
                    ),
                  ),
                ]
              )
            )

          ],
        ),

        Container(
          width: screenWidth / 3,
          child: Center(
              child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Container(
                  width: screenWidth/3,
                  height: screenWidth/3,
//                child: Image.asset('lib/assets/tealBorder.png')
                ),

                Center(
                  heightFactor: 1.12,
                  child: CachedNetworkImage(
                    imageUrl: myMarka.mImageUrl,
                    placeholder: CircularProgressIndicator(),
                    alignment: Alignment.center,
                    width: screenWidth/3,
                  ),
                ),
              ]
          )),
        ),
      ]),
    );
  }
}

class Stock_Holder extends StatelessWidget {
  final String name;
  final Color color;
  final double yuzdelik;
  Stock_Holder({this.name, this.color, this.yuzdelik});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [

        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(color: color, width: 5.0))),
          width: 60.0, height: 60.0,
          alignment: Alignment.center,
          child: Text("%" + yuzdelik.toString(), style: TextStyle(fontSize: 12.0, color: niceColor),),
          ),

        Container(alignment: Alignment.topCenter,width: 70.0,height: 35.0,child: Text(name,textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0),)),

      ]
    );
  }
}

class Yerli extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  List<Marka> yerliList = [];

    for(int i = 0; i < mList.length; i++){
      if(mList[i].ulke == "Türkiye"){
        yerliList.add(mList[i]);
        }
    }

    return  GridListItems(itemList: yerliList);
  }
}


class Yabanci extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Marka> yabanciList = [

    ];

    for(int i = 0; i < mList.length; i++){
      if(mList[i].mensei != "Türkiye"){
        yabanciList.add(mList[i]);
        }
    }

    return  GridListItems(itemList: yabanciList);
  }
}

class YariYerli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Marka> yariYerliList = [

    ];

    for(int i = 0; i < mList.length; i++){
      if(mList[i].mensei.contains('Türkiye') && mList[i].mensei != 'Türkiye'){
        yariYerliList.add(mList[i]);
        }
    }

    return  GridListItems(itemList: yariYerliList);
  }
}

class GridListItems extends StatelessWidget {
  const GridListItems({
    Key key,
    @required this.itemList,
  }) : super(key: key);

  final List<Marka> itemList;

  @override
  Widget build(BuildContext context) {

    final queryData = MediaQuery.of(context);
    final double screenWidth = queryData.size.width;
    final double screenHeight = queryData.size.height;

    return Container(
                  margin: EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: InkWell(
                          onTap: () => navigatePage(context, itemList[index]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(alignment: Alignment.center, child: Text(itemList[index].mName, style: TextStyle(color: Colors.white, fontSize: 16.0)),color: primaryColor,width: screenWidth/2,height: screenHeight/25,),
                              //Padding(padding: EdgeInsets.only(top: 8.0, left: 16.0), child: Text(itemList[index].mName),),

                              Center(child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[

                                  Container(
                                    width: screenWidth/3.5,
                                    height: screenWidth/3.5,
                                    //child: Image.asset("lib/assets/lineyFrame.png", color: Colors.teal,),
                                  ),

                                  Center(
                                    heightFactor: 1.12,
                                    child: CachedNetworkImage(
                                      imageUrl: itemList[index].mImageUrl,
                                      placeholder: CircularProgressIndicator(),
                                      alignment: Alignment.center,
                                      width: screenWidth/5.2,
                                      height: screenWidth/3.7,
                                    ),
                                  )
                                ]
                              )),
                                Expanded(
                                  child: Container(
                                    color: Colors.black54,
                                    child: Row(
                                      children: <Widget>[
                                         Expanded(child: IconButton(icon: Icon(Icons.info), color: gridIconColor, onPressed: () => navigatePage(context, itemList[index]),)),
                                         Expanded(child: IconButton(icon: Icon(Icons.public), color: gridIconColor, onPressed: () => _launchURL(itemList[index]))),
                                         Expanded(child: IconButton(icon: Icon(Icons.share), color: gridIconColor, onPressed: () => _shareMessage(itemList[index])))
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );

                    }
                    ),
              );
  }
}
//Search Page
_shareMessage(Marka marka){
  List<String> infoList = infoBuild(marka);

    String name = marka.mName;//0 = Resmi isim
    String kTarih = infoList[1];//1 = Kuruluş Tarihi
    String kurucular = infoList[2];//2 = Kurucular
    String hisseBilg = infoList[3];//3 = Hisse Bilgileri
    List<String> sirketHisse = hisseBilg.split(';');

    List<String> hisseAyrinti = sirketHisse[0].split(':');
    String bigShareHolder = hisseAyrinti[0].toString();
    String bigShare = hisseAyrinti[1].toString();

  Share.share("${name}'ın ${bigShare} hissesinin ${bigShareHolder}'a ait olduğunu biliyor muydunuz?");
}

_launchURL(Marka marka) async {

  String url = 'https://google.com';

    String fullYazi = marka.mInfo.toString();

    HtmlParser parser = new HtmlParser();
    List elementList = parser.parse(fullYazi);

    for(int i = 0; i < elementList.length; i++){

      String tag = elementList[i]['tag'].toString();
      if(tag == 'h5'){
        url = elementList[i]['text'].toString();
      }
    }
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return newSearch();
  }
}

class newSearch extends StatefulWidget {
  @override
  _newSearchState createState() => _newSearchState();
}

class _newSearchState extends State<newSearch> {
   TextEditingController txtController = new TextEditingController();
  List<Marka> aramaList = [];


  void navigatePage(BuildContext context, Marka myMarka){
   Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new ReadPage(myMarka)));
  }

  void txtChanged(String text){

    if(text != null){
      aramaList.clear();
      for(int i=0; i< mList.length; i++){
        String line = mList[i].mName;

        if(line.toLowerCase().contains(text.toLowerCase())){
          setState(() {
            aramaList.add(mList[i]);
                    });
          }
      }
    }
  }

  @override
  void initState() {
     super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField( decoration: InputDecoration(hintText: "Arama"), controller: txtController, onChanged: txtChanged),
        actions: <Widget>[
          Icon(Icons.search)
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 16.0),
        itemCount: aramaList == null? 0 : aramaList.length,
        itemBuilder: (context, i){
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 12.0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12.0,bottom: 12.0),
              height: 100.0,
              child: ListTile(
                onTap: () => navigatePage(context, aramaList[i]),
                title: Text(aramaList[i].mName),
                leading: CachedNetworkImage(
                    imageUrl: aramaList[i].mImageUrl,
                    placeholder: CircularProgressIndicator(),
                    )
                    ),
                    ),
          );
        },
    )
    );
  }
}

class UlkeOzel extends StatelessWidget {

  String ulke;

  UlkeOzel({this.ulke});

  @override
  Widget build(BuildContext context) {
    List<Marka> ozelList = [

    ];

    for(int i = 0; i < mList.length; i++){
      if(mList[i].ulke == ulke){
          ozelList.add(mList[i]);
        }
    }

    return  Scaffold(
      appBar: AppBar(title: Text(ulke),),
      body: GridListItems(itemList: ozelList)
      );
  }
}

class KategoriOzel extends StatelessWidget {

  int index;

  KategoriOzel({this.index});

  @override
  Widget build(BuildContext context) {
    List<Marka> ozelList = [];
    String kat = kategoriList[index];
    for(int i = 0; i < mList.length; i++){
      if(mList[i].kategori == kat){
        ozelList.add(mList[i]);
      }
    }

    return  Scaffold(
        appBar: AppBar(title: Text(kat),),
        body: GridListItems(itemList: ozelList)
    );
  }
}
