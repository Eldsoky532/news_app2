import 'ariticle.dart';

class AritcalResponse
{
  final List<ArticleModel> articles;
  final String error;

  AritcalResponse(this.articles,this.error);
  
  AritcalResponse.fromJson(Map<String,dynamic> json)
  : articles=(json['articles'] as List).map((e) => new ArticleModel.fromJson(e)).toList(),error='';


  AritcalResponse.withError(String errorvalue)
  : articles=[],error=errorvalue;



  
  
  
}