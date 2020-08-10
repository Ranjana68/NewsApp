import 'package:flutter/material.dart';
import 'package:news_app_api/views/article_view.dart';

Widget MyAppBar(){
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "AppyHigh",
          style:
          TextStyle(color: Colors.pink, fontWeight: FontWeight.w800),
        ),
        Text(
          " Assignment",
          style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.w800),
        )
      ],
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}


class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  bool val;
  NewsTile({this.val,this.imgUrl, this.desc, this.title, this.content, @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              postUrl: posturl,
            )
        ));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 5),
          //padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(25,10,25,10),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: val?LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black,
                    Colors.white,
                  ],
                ):LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[

                    Colors.blueGrey,
                    Colors.black,
                  ],
                ),
                //color: val?Colors.white:Colors.black,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6)),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(

                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(

                        imgUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 2,),
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                        color: val?Colors.black87:Colors.white,

                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),

                  Text(
                    desc,
                    maxLines: 2,
                    style: TextStyle(
                        color: val?Colors.black:Colors.white,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
