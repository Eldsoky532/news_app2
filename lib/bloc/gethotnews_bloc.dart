
import 'package:news_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../model/aritcals_response.dart';

class GetHotNewsBloc
{
  final NewsRepository _repository=NewsRepository();

  final BehaviorSubject<AritcalResponse> _subject=
  BehaviorSubject<AritcalResponse>();

  getHotNew() async
  {
    AritcalResponse response= await _repository.getHotNews();
    _subject.sink.add(response);
  }

dispose()
{
  _subject.close();
}

BehaviorSubject<AritcalResponse> get subject=>_subject;

}
final  getHotNewsBloc=GetHotNewsBloc();