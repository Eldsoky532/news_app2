import 'package:news_app/model/aritcals_response.dart';
import 'package:news_app/model/source_response.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/repository.dart';

class GetSearchBloc
{
  final NewsRepository _repository=NewsRepository();

  final BehaviorSubject<AritcalResponse> _subject=
  BehaviorSubject<AritcalResponse>();

  search(String sourceid) async
  {
    AritcalResponse response=await _repository.search(sourceid);
    _subject.sink.add(response);
  }

  dispose()
  {
    _subject.close();
  }
  BehaviorSubject<AritcalResponse> get subject=>_subject;

}
final  searchBloc=GetSearchBloc();