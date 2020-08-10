import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/helper/news.dart';
import 'package:news_app_api/helper/widgets.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class CategoryNews extends StatefulWidget {

  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}
///ca-app-pub-3586681192678739~2344655876
class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }
  Widget adsContainer() {
    const _adUnitID = "ca-app-pub-3940256099942544/8135179316";

    var _nativeAdController = NativeAdmobController();
    return Container(
      margin: EdgeInsets.all(10.0),
     // color: Colors.green[100],
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xffa7ffeb),
            //Colors.black54,
            Color(0xffbdbdbd),
          ],
        ),
      ),
      //You Can Set Container Height
      height: 250,
      child: NativeAdmob(

        // Your ad unit id
        adUnitID: _adUnitID,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
        error: CupertinoActivityIndicator(),
      ),
    );
  }
  bool change=true;


  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "AppyHigh ",
              style:
              TextStyle(color: Colors.pink, fontWeight: FontWeight.w800),
            ),
            Text(
              "Assignment",
              style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.w800),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share,color: Colors.transparent,)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: newslist.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if(index%2==0) change=true;
                    else change=false;

                    if(index%5==0)
                      return Container(
                        child: Column(
                          children: [
                            adsContainer(),
                            NewsTile(
                              val:change,
                              imgUrl: newslist[index].urlToImage ?? "",
                              title: newslist[index].title ?? "",
                              desc: newslist[index].description ?? "",
                              content: newslist[index].content ?? "",
                              posturl: newslist[index].articleUrl ?? "",
                            ),
                          ],
                        ),
                      );
                    return NewsTile(
                      val: change,
                      imgUrl: newslist[index].urlToImage ?? "",
                      title: newslist[index].title ?? "",
                      desc: newslist[index].description ?? "",
                      content: newslist[index].content ?? "",
                      posturl: newslist[index].articleUrl ?? "",
                    );
                  }),
            ),
        ),
      ),
    );
  }
}




