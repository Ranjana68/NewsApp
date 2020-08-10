import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/helper/data.dart';
import 'package:news_app_api/helper/widgets.dart';
import 'package:news_app_api/models/categorie_model.dart';
import 'package:news_app_api/views/categorie_news.dart';
import '../helper/news.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _loading;
  var newslist;


  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();

  }


  Widget adsContainer() {
    //var testId="AA40CFF1480637351F664AE88AB9BA90";
     const _adUnitID = "ca-app-pub-3940256099942544/8135179316";
    var _nativeAdController = NativeAdmobController();
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      //color: Colors.green[100],
      decoration: const BoxDecoration(
      borderRadius:BorderRadius.all(Radius.circular(40.0)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xffa7ffeb),
            Colors.white60,
          ],
        ),
      ),
      //You Can Set Container Height
      height: 250,
      child: new NativeAdmob(

        // Your ad unit id
        adUnitID: _adUnitID,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
        error: CupertinoActivityIndicator(),
      ),
    );
  }

  bool change=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlueAccent,
              offset: Offset(10.0, 0.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(8),
        height: 90,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                imageAssetUrl: categories[index].imageAssetUrl,
                categoryName: categories[index].categorieName,
              );
            }),
      ) ,
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories is in bottom nav

                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 2),
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
                                val:change,
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            newsCategory: categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0,2,14,2),

        child: Stack(

          children: <Widget>[
            ClipRRect(

              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 70,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,

              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
            )
          ],
        ),
      ),
    );
  }
}
