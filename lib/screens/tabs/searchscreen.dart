import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_search_bloc.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/model/ariticle.dart';
import 'package:news_app/screens/detailsnews.dart';
import 'package:news_app/style//theme.dart' as Style;

import '../../model/aritcals_response.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchBloc..search("");
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          child: TextFormField(
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.black),
            controller: _searchController,
            onChanged: (changed) {
              searchBloc..search(_searchController.text);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey[100],
              suffixIcon: _searchController.text.length > 0 ? IconButton(
                  icon: Icon(EvaIcons.backspaceOutline, color: Colors.grey[500], size: 16.0,),
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _searchController.clear();
                      searchBloc..search(_searchController.text);
                    });
                  }): Icon(EvaIcons.searchOutline, color: Colors.grey[500], size: 16.0,),
              enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(30.0)),
              contentPadding: EdgeInsets.only(
                  left: 15.0, right: 10.0),
              labelText: "Search...",
              hintStyle: TextStyle(
                  fontSize: 14.0,
                  color: Style.Colors.grey,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            autocorrect: false,
          ),
        ),
        Expanded(child: StreamBuilder<AritcalResponse>(
          stream: searchBloc.subject.stream,
          builder: (context, AsyncSnapshot<AritcalResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null &&
                  snapshot.data!.error.length > 0) {
                return Container();
              }
              return _buildSourceNewsWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return buildLoadingWidget();
            }
          },
        ))
      ],
    );
  }
  Widget _buildSourceNewsWidget(AritcalResponse data) {
    List<ArticleModel> articles = data.articles;

    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No more news",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailNews(
                          article: articles[index],
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  color: Colors.white,
                ),
                height: 150,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(
                              articles[index].title,
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14.0)),
                          Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[

                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10.0),
                        width: MediaQuery.of(context).size.width * 2 / 5,
                        height: 130,
                        child:
                        FadeInImage.assetNetwork(
                            alignment: Alignment.topCenter,
                            placeholder: 'assets/img/mm.jpg',
                            image: articles[index].img == null
                                ? "https://www.google.com.eg/imgres?imgurl=https%3A%2F%2Fimg.freepik.com%2Ffree-photo%2Fyoung-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg&imgrefurl=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Fmodern-woman&tbnid=oot4quHMjvK0HM&vet=12ahUKEwiywee7z4b8AhXvUaQEHTnKACsQMygCegUIARDpAQ..i&docid=YAD6EJ2CYoRkFM&w=626&h=417&q=woman&hl=en&ved=2ahUKEwiywee7z4b8AhXvUaQEHTnKACsQMygCegUIARDpAQ"
                                : articles[index].img,
                            fit: BoxFit.fitHeight,
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height * 1 / 3))
                  ],
                ),
              ),
            );
          });
  }

}