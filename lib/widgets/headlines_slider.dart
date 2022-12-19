import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/gettopheadlinesBloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/model/aritcals_response.dart';
import 'package:news_app/model/ariticle.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlinesSliderWidget extends StatefulWidget {
  const HeadlinesSliderWidget({Key? key}) : super(key: key);

  @override
  State<HeadlinesSliderWidget> createState() => _HeadlinesSliderWidgetState();
}

class _HeadlinesSliderWidgetState extends State<HeadlinesSliderWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getTopHeadlinesBloc..getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AritcalResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
        builder: (BuildContext context, AsyncSnapshot<AritcalResponse> snapshot){
        if(snapshot.hasData)
          {
            if(snapshot.data!.error!=null&& snapshot.data!.error.length>0)
              {
                return buildErrorWidget(snapshot.data!.error);
              }
            return _buildHeadlinesSlider(snapshot.data!);

          }else if(snapshot.hasError){
          return buildErrorWidget(snapshot.data!.error);
        }else
          {
            return buildLoadingWidget();
          }
        }
    );
  }
  Widget _buildHeadlinesSlider(AritcalResponse data)
  {
    List<ArticleModel> articales=data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false,
          height: 200.0,
          viewportFraction: 0.9
        ),
        items: getExpenseSlider(articales),
      ),
    );
  }
  getExpenseSlider(List<ArticleModel> articales)
  {
    return articales.map((e) => GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(
          left: 5.0,
          right: 5.0,
          top: 10.0,
          bottom: 10.0
        ),
        child: Stack(
          children: [
            Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: e.img != null ?NetworkImage(e.img) : AssetImage("assets/img/mm.jpg") as ImageProvider
                ),
                
              ),

            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [
                    0.1,0.9
                  ],
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.white.withOpacity(0.0),

                  ]
                )
              ),
            ),
            Positioned(
              bottom: 30.0,
                child: Container(
                  padding: EdgeInsets.only(left: 10.0,right: 10.0),
                  width: 250.0,
                  child: Column(
                    children: [
                      Text(e.title,style: TextStyle(
                        height: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0
                      )),
                    ],
                  ),
                )
            ),
            Positioned(
                bottom: 10.0,left: 10.0,
                child: Text(
                  e.source.name,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 9.0
                  ),
                ),
            ),
           /* Positioned(
                bottom: 10.0,
                right: 10.0,
                child: Text(
                  timeUntil(DateTime.parse(e.date!)),
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 9.0),
                )),*/
          ],
        ),
      ),
    )).toList();
  }
  String timeUntil(DateTime? date) {
    return timeago.format(date!, allowFromNow: true, locale: 'en');
  }
}
