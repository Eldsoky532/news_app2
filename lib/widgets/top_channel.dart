import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_source_bloc.dart';

import '../model/source.dart';
import '../model/source_response.dart';
import 'package:news_app/style/theme.dart' as Style;

import '../screens/sourcedetails.dart';

class TopChannelWidget extends StatefulWidget {
  const TopChannelWidget({Key? key}) : super(key: key);

  @override
  State<TopChannelWidget> createState() => _TopChannelWidgetState();
}

class _TopChannelWidgetState extends State<TopChannelWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSourceBloc..getSourceNews();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourceBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error.length > 0) {
            return Container();
          }
          return _buildSourcesWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  } Widget _buildSourcesWidget(SourceResponse data) {
    List<SourceModel> sources = data.articles;
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Sources",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 115.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sources.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(
                  top: 10.0,
                  right: 0.0
              ),
              width: 80.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                    MaterialPageRoute(
                          builder: (context) => SourceDetail(
                            source: sources[index],
                          )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[                    Hero(
                      tag: sources[index].id,
                      child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius:
                                5.0,
                                spreadRadius:
                                1.0,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ],

                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/logos/${sources[index].id}.png")),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      sources[index].name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      sources[index].category,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }

}


