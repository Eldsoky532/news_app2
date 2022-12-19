import 'package:news_app/model/source.dart';

import 'ariticle.dart';

class SourceResponse
{
  final List<SourceModel> articles;
  final String error;

  SourceResponse(this.articles,this.error);

  SourceResponse.fromJson(Map<String,dynamic> json)
      : articles=(json['sources'] as List).map((e) => new SourceModel.fromJson(e)).toList(),error='';


  SourceResponse.withError(String errorvalue)
      : articles=[],error=errorvalue;






}