import 'package:rxdart/rxdart.dart';

import '../model/aritcals_response.dart';
import '../repository/repository.dart';

class GetSourceNewsBloc
{
  final NewsRepository _repository=NewsRepository();

  final BehaviorSubject<AritcalResponse> _subject=
  BehaviorSubject<AritcalResponse>();

  getSourceNews(String sourceid) async
  {
    AritcalResponse response=await _repository.getSourceNews(sourceid);
    _subject.sink.add(response);
  }

  void drainStream()
  {
    _subject.value==null;
  }
  void dispose()async
  {
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<AritcalResponse> get subject=>_subject;

}

final getSourceNewsBloc=GetSourceNewsBloc();