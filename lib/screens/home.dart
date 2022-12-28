import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forqan/constantes/colors.dart';
import 'package:forqan/models/surah.dart';
import 'package:forqan/screens/reading_page.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/surah_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    readJson();
    super.initState();
  }
void readPage(BuildContext context,chapters,int index,int begin,int end,bool all){
  Navigator.push(
          
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
                int endi = fullPage(index,begin,end)+begin;
                print("begining :$begin");
                print("ending :$endi");
                if(all)
                return SurahPage(surah: index, beginning: begin, ending: end,);
                return SurahPage(surah: index, beginning: begin, ending: endi,);
                }
                ,
          ),
        );
}
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    debugPrint(surahList.length.toString());
    setState(() {});
  }

  int fullPage(int surah,int begin,int end){
            int s = surah;
            List<String> veses =[];
            int i =1;
            
            while(veses.toString().length<600){
                    if(begin+i>surahList[s].versesCount-1){
                      
                      break;
                      
                    }
                    
                    String b =quran.getVerse(s,i, verseEndSymbol: false);
                   
                    veses.add(b);
                    i++;
                    
            }
            return i;
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        floatingActionButton: readRandomly(context),
        appBar: AppBar(
          leading: Transform.rotate(
            angle: isReverse ? pi : 2 * pi,
            child: IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {
                  setState(() {
                    isReverse = !isReverse;
                  });
                }),
          ),
        ),
        body: surahList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : chaptersList(isReverse ? surahList.reversed.toList() : surahList),
      ),
    );
  }

  Widget readRandomly(BuildContext context){
  void onPressed(){
     var randomSurah = Random().nextInt(114); 
     var begining = Random().nextInt(surahList[randomSurah].versesCount)+1;
    //  randomSurah = 1;
    //  begining= 5;
     print("randomSurah = $randomSurah");
     print("begining = $begining");
     if(begining >surahList[randomSurah].versesCount-3){
       readPage(context,surahList,randomSurah,begining,surahList[randomSurah].versesCount,false);
     }
     else{
       readPage(context,surahList,randomSurah,begining,begining+3,false);
     }
     
  }
  return FloatingActionButton(
    child: Icon(Icons.read_more),
    onPressed: onPressed
    
    );

}

  Widget chaptersList(List<Surah> chapters) {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: Text(chapters[index].id.toString()),
        ),
        title: Text(chapters[index].name),
        subtitle: Text(chapters[index].versesCount.toString()),
        trailing: Text(
          chapters[index].arabicName,
          style: GoogleFonts.cairo(
            fontSize: 18,
          ),
        ),
        onTap: () => readPage(context,chapters,index,1,chapters[index].versesCount,true)
      ),
      separatorBuilder: (context, index) => Divider(height: 5,color: writingColor,),
      itemCount: chapters.length,
    );
  }
}





