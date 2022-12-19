import 'package:flutter/material.dart';
import 'package:news_app/widgets/top_channel.dart';

import '../../widgets/headlines_slider.dart';
import '../../widgets/hot_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlinesSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Top channels',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17.0
          ),
          ),
        ),
        TopChannelWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Hot News',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17.0
            ),
          ),
        ),
        HotNewsWidget()
      ],
    );
  }
}
