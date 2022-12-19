import 'package:news_app/model/source_response.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/repository.dart';

class GetSourceBloc
{
  final NewsRepository _repository=NewsRepository();

  final BehaviorSubject<SourceResponse> _subject=
  BehaviorSubject<SourceResponse>();

  getSourceNews() async
  {
    SourceResponse response=await _repository.getSources();
    _subject.sink.add(response);
  }
  BehaviorSubject<SourceResponse> get subject => _subject;

}
final getSourceBloc = GetSourceBloc();