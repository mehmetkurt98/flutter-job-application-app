import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase98/maintextformfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'firebase_options.dart';

String data = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: FirebaseCrud(),
  ));
}

class FirebaseCrud extends StatefulWidget {
  const FirebaseCrud({Key? key}) : super(key: key);

  @override
  State<FirebaseCrud> createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  String value = "";
  String? ad, id, adres, pozisyon, okul;
  String? tarih;
  TextEditingController idController = TextEditingController();
  TextEditingController adController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  TextEditingController pozisyonController = TextEditingController();
  TextEditingController okulController = TextEditingController();
  TextEditingController tarihController = TextEditingController();

  _idAl(idDegeri) {
    this.id = idDegeri;
  }

  _adAl(adDegeri) {
    this.ad = adDegeri;
  }

  _tarihAl(tarihDegeri) {
    this.tarih = tarihDegeri;
  }

  _adresAl(adresDegeri) {
    this.adres = adresDegeri;
  }

  _okulAl(okulDegeri) {
    this.okul = okulDegeri;
  }

  _pozisyonAl(pozisyonDegeri) {
    this.pozisyon = pozisyonDegeri;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "İŞ BAŞVURU FORMU",
          style: TextStyle(fontSize: 18.0, color: Colors.blueAccent),
        ),
        centerTitle: true,
        /*
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/resim1.png'), fit: BoxFit.cover)),
        ),

         */
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (String idDegeri) {
                  _idAl(idDegeri);
                },
                controller: idController,
                decoration: InputDecoration(
                  labelText: "Başvuru ID",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainTextFormField(
                  labelText: "Ad-Soyad",
                  controller: adController,
                  onChanged: (String adDegeri) {
                    _adAl(adDegeri);
                  },
                )),
            //////////////////////////////////////////////////////////////////
            /*
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainTextFormField(
                  labelText: "Başvurulan pozisyon",
                  onChanged: (String pozisyonDegeri) {
                    adAl(pozisyonDegeri);
                  },
                )),

             */
            /////////////////////////////////////////////////////////////////

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (String pozisyonDegeri) {
                  _pozisyonAl(pozisyonDegeri);
                },
                controller: pozisyonController,
                decoration: InputDecoration(
                  labelText: "Başvurulan Pozisyon",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (String okulDegeri) {
                  _okulAl(okulDegeri);
                },
                controller: okulController,
                decoration: const InputDecoration(
                  labelText: "Mezun olduğunuz okul",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (String adresDegeri) {
                  _adresAl(adresDegeri);
                },
                controller: adresController,
                decoration: const InputDecoration(
                  labelText: "Adres",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (String tarihDegeri) {
                  _tarihAl(tarihDegeri);
                },
                controller: tarihController,
                decoration: const InputDecoration(
                  labelText: "Tarih",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                  ),
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Başvurulan Şirket: "),
                    Text(
                      value == "-1" ? " " : value,
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      veriEkle();
                      resetController();
                    },
                    child: Text("Ekle"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      onPrimary: Colors.white,
                      shadowColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FlutterBarcodeScanner.scanBarcode(
                              "#000000", "İptal", false, ScanMode.QR)
                          .then((value) {
                        this.value = value;
                        setState(() {});
                      });
                    },
                    child: Text("QR KOD OKU"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.redAccent,
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("İş").snapshots(),
              builder: (context, alinanVeri) {
                if (alinanVeri.hasError) return Text("Aktarım Başarısız");
                if (alinanVeri.data == null) return CircularProgressIndicator();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: alinanVeri.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot satirVerisi = alinanVeri.data?.docs[index]
                        as DocumentSnapshot<Object?>;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30, 8, 0, 8),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                veriGuncelle();
                              },
                              child: Text("Güncelle"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                onPrimary: Colors.white,
                                shadowColor: Colors.white,
                                elevation: 5,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                veriSil(satirVerisi["isId"]);
                              },
                              child: Text("Sil"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                onPrimary: Colors.white,
                                shadowColor: Colors.white,
                                elevation: 5,
                              ),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(satirVerisi["isId"])),
                            Expanded(child: Text(satirVerisi["isAd"])),
                            Expanded(child: Text(satirVerisi["isPozisyon"])),
                            Expanded(child: Text(satirVerisi["isOkul"])),
                            Expanded(child: Text(satirVerisi["isAdres"])),
                            Expanded(child: Text(satirVerisi["isTarih"])),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void veriEkle() {
    DocumentReference veriYolu =
        FirebaseFirestore.instance.collection("İş").doc(id);
    Map<String, dynamic> formlar = {
      "isId": id,
      "isAd": ad,
      "isPozisyon": pozisyon,
      "isOkul": okul,
      "isAdres": adres,
      "isTarih": tarih.toString(),
    };
    veriYolu.set(formlar).whenComplete(() {
      Fluttertoast.showToast(
          msg: id! +
              " Numaralı başvurunuz tarafımızca kaydedilmiştir.Yakın zamanda görüşmek üzere!");
    });
  }

  void resetController() {
    idController.text = "";
    adController.text = "";
    adresController.text = "";
    pozisyonController.text = "";
    okulController.text = "";
    tarihController.text = "";
    value = "";
  }

/*
  void veriOku() {
    DocumentReference veriOkumaYolu =
        FirebaseFirestore.instance.collection("İş").doc(id);
    veriOkumaYolu.get().then((alinanDeger) {
      Map<String, dynamic> alinanVeri = alinanDeger.data();
      String idTutucu = alinanVeri["isId"];
      String adTutucu = alinanVeri["isAd"];
      String pozisyonTutucu = alinanVeri["isPozisyon"];
      String okulTutucu = alinanVeri["isOkul"];
      String adresTutucu = alinanVeri["isAdres"];
      String tarihTutucu = alinanVeri["isTarih"];

      Fluttertoast.showToast(
          msg: "ID:" +
              idTutucu +
              "Adı:" +
              adTutucu +
              "Pozisyon:" +
              pozisyonTutucu +
              "Okul:" +
              okulTutucu +
              "Adres:" +
              adresTutucu +
              "Tarih:" +
              tarihTutucu);
    });
  }
  */

  void veriSil(String index) {
    DocumentReference veriSilmeYolu =
        FirebaseFirestore.instance.collection("İş").doc(index);
    veriSilmeYolu.delete().whenComplete(() {
      Fluttertoast.showToast(
          msg: index! + " Numaralı başvurunuz veritabanından silinmiştir.");
    });
  }

  void veriGuncelle() {
    DocumentReference veriGuncellemeYolu =
        FirebaseFirestore.instance.collection("İş").doc(id);
    Map<String, dynamic> guncellenecekVeri = prepareDataMapList();
    veriGuncellemeYolu.update(guncellenecekVeri).whenComplete(() {
      Fluttertoast.showToast(msg: id! + " Numaralı başvurunuz güncellenmiştir");
    });
  }

  Map<String, dynamic> prepareDataMapList() {
    Map<String, dynamic> guncellenecekVeri = {
      "isId": id,
      "isAd": ad,
      "isPozisyon": pozisyon,
      "isOkul": okul,
      "isAdres": adres,
      "isTarih": tarih.toString()
    };
    return guncellenecekVeri;
  }
}
