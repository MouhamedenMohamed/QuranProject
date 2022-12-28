import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forqan/constantes/colors.dart';
import 'package:forqan/models/surah.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/surah_data.dart';

class SurahPage extends StatelessWidget {
  final int surah;
  final int beginning ;
  final int ending ;
  SurahPage({required this.surah, required this.beginning, required this.ending});
  @override
  Widget build(BuildContext context) {
    int count = ending-beginning;
    int index = surah;
    // ignore: dead_code
    bool tawbah = (surah==9 || beginning!=0)?true:false;
   
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: EdgeInsets.all(15),
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: header(!tawbah),
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
              text: TextSpan(
                
                children: [
                  
                  for (int i=beginning ; i <= ending; i++) ...{
                    TextSpan(
                      text: ' ' +
                          quran.getVerse(index, i, verseEndSymbol: false) +
                          ' ',
                      style: TextStyle(
                        
                        fontFamily: 'Kitab',
                        fontSize: 25,
                        color: writingColor,
                      ),
                    ),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: CircleAvatar(
                          child: Text(
                            '$i',
                            textAlign: TextAlign.center,
                            textScaleFactor: i.toString().length <= 2 ? 1 : .8,
                          ),
                          radius: 14,
                        )
                        )
                  },
                  
                ],
              ),
            ),
            bottom(surah,context),
          ]),
        ),
      ),
    );
  }

  Widget header(bool bismillahthere) {
    String bismillah = bismillahthere ? quran.basmala:'اعوذ بالله من الشيطان الرجيم';
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('',
          // surah.arabicName+'    ${surah.id}',
          style: TextStyle(
            fontFamily: 'Aldhabi',
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' ' + bismillah + ' ',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'NotoNastaliqUrdu',
            fontSize: 24,
          ),
        ),
      ],
    ));
  }


  Widget bottom(int surah,BuildContext context){
    return Container(
      height: 50,
      color: appColor,
      child: GestureDetector(
        child: Text("Next Sourah"),
        onTap: (){
          print("Next Sourah");
          if(surah==113){
            SurahPage(beginning: 1,ending: 5,surah: 0,);
          }
          else{
              int i = surah+1;
              Navigator.push(
          
          context,MaterialPageRoute<void>(
            builder: (BuildContext context) {
                return SurahPage(beginning: 1,ending: 7,surah:i,);
                }
                ,
          ));
              
          }
        },
      ),
    );
  }
}


